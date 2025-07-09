<?php

namespace App\Repositories;

use Illuminate\Support\Facades\Http;

class CountryRepository {
    public function fetchAll(): array {
        $response = Http::get('https://restcountries.com/v3.1/all?fields=area,population,name');
        return $response->json();
    }
}
