<?php

namespace App\Application\Services;

use App\Domain\Entities\Country;
use Illuminate\Support\Facades\Http;

class CountryService {
    public function fetchCountries(): array {
        $response = Http::get('https://restcountries.com/v3.1/all?fields=area,population,name');
        $raw = $response->json();

        $countries = [];
        foreach ($raw as $data) {
            $name = $data['name']['common'] ?? 'Unknown';
            $area = $data['area'] ?? 0;
            $population = $data['population'] ?? 0;
            $countries[] = new Country($name, $area, $population);
        }

        return $countries;
    }

    public function getTopByDensity(int $limit): array {
        $all = $this->fetchCountries();
        usort($all, fn($a, $b) => $b->density <=> $a->density);
        return array_slice($all, 0, $limit);
    }
}
