<?php

namespace App\Http\Controllers\Dashboard;

use App\Http\Controllers\Controller;
use Elseyyid\LaravelJsonLocationsManager\Models\Strings;
use Illuminate\Support\Facades\DB;
use Throwable;

class TranslateController extends Controller
{
    public function autoTranslate($lang)
    {
        // Load the English (en) and target language JSON files
        $enJsonFilePath = base_path('lang/en.json');
        $targetJsonFilePath = base_path("lang/$lang.json");

        // Get all keys from en.json file
        $enDataToTranslate = json_decode(file_get_contents($enJsonFilePath), true);

        // If the target language file doesn't exist, create a copy from en.json with null values
        if (! file_exists($targetJsonFilePath)) {
            $nullValuesArray = array_fill_keys(array_keys($enDataToTranslate), null);
            $newJsonF = json_encode($nullValuesArray, JSON_PRETTY_PRINT);
            file_put_contents($targetJsonFilePath, $newJsonF);
        }

        // Get all keys from the target language JSON file
        $targetDataToTranslate = json_decode(file_get_contents($targetJsonFilePath), true);

        // Identify missing keys in the target language file and add them
        $missingKeys = array_diff_key($enDataToTranslate, $targetDataToTranslate);
        if (! empty($missingKeys)) {
            foreach ($missingKeys as $key) {
                if (! isset($targetDataToTranslate[$key])) {
                    // Update the target language JSON file based on the translation
                    $targetDataToTranslate[$key] = null;
                }
            }
            // Update the target language JSON file
            $newJson = json_encode($targetDataToTranslate, JSON_PRETTY_PRINT);
            file_put_contents($targetJsonFilePath, $newJson);
        }

        // Translate 100 untranslated keys or all if less than 100
        $untranslatedKeys = array_filter($targetDataToTranslate, function ($value, $key) {
            if (empty($key) || $key === null) {
                // Handle the case where $key is empty or null (if needed)
                return false; // or return true; depending on your logic
            }

            return $value === null || $value === '';
        }, ARRAY_FILTER_USE_BOTH);
        $keysToTranslate = array_slice(array_keys($untranslatedKeys), 0, 100);

        // Check if there are keys to translate
        if (! empty($keysToTranslate)) {
            foreach ($keysToTranslate as $key) {

                // if there is an key in target not exist in main then copy it
                try {
                    $enKeyValue = $enDataToTranslate[$key];
                } catch (Throwable $th) {
                    $enDataToTranslate[$key] = $key;
                    // Update the English language JSON file
                    $newEnJson = json_encode($enDataToTranslate, JSON_PRETTY_PRINT);
                    file_put_contents($enJsonFilePath, $newEnJson);
                }
                if ($enDataToTranslate[$key] == null || empty($enDataToTranslate[$key]) || $enDataToTranslate[$key] == ' ') {
                    $enDataToTranslate[$key] = $key;
                }

                try {
                    // Translate using Groq API
                    $groqKey = DB::table('settings')->where('id', 1)->value('openai_api_secret');
                    // Allow override with Groq key stored separately, or use hardcoded fallback
                    $groqApiKey = config('services.groq.key', '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');
                    $payload = json_encode([
                        'model' => 'openai/gpt-oss-20b',
                        'messages' => [
                            ['role' => 'system', 'content' => 'You are a translator. Translate the given text to the target language. Return ONLY the translated text, nothing else. Keep HTML tags, variables like :name %s {{var}}, and brand names unchanged.'],
                            ['role' => 'user', 'content' => "Translate to language code '$lang': " . $enDataToTranslate[$key]],
                        ],
                        'max_tokens' => 300,
                    ]);
                    $ch = curl_init('https://api.groq.com/openai/v1/chat/completions');
                    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                    curl_setopt($ch, CURLOPT_POST, true);
                    curl_setopt($ch, CURLOPT_POSTFIELDS, $payload);
                    curl_setopt($ch, CURLOPT_HTTPHEADER, [
                        'Content-Type: application/json',
                        'Authorization: Bearer ' . $groqApiKey,
                    ]);
                    $response = curl_exec($ch);
                    curl_close($ch);
                    $data = json_decode($response, true);
                    $translatedText = $data['choices'][0]['message']['content'] ?? null;
                    if (empty($translatedText)) {
                        continue;
                    }
                    $translatedText = trim($translatedText);
                } catch (Throwable $th) {
                    continue;
                }

                // Update the target language JSON file based on the translation
                $targetDataToTranslate[$key] = $translatedText;

                // Update the Strings model based on the translation
                $column_name = $lang;
                $query = Strings::query();

                if ($column_name == 'edit') {
                    // Logic for handling 'edit' column
                    $query->update([$column_name => $translatedText]);
                } else {
                    // Logic for other columns
                    $query->where('en', '=', $key)->update([$column_name => $translatedText]);
                }
            }

            // Update the target language JSON file
            $newJson = json_encode($targetDataToTranslate, JSON_PRETTY_PRINT);
            file_put_contents($targetJsonFilePath, $newJson);

            return back()->with(['message' => __('Translations have been updated successfully.'), 'type' => 'success']);
        }

        // All keys have been translated
        return back()->with(['message' => __('All translations have been completed.'), 'type' => 'info']);

    }
}
