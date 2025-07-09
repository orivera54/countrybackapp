<?php
namespace App\Services;

use App\DTOs\CountryDTO;
use App\Repositories\CountryRepository;

class CountryService {
    public function __construct(private CountryRepository $repository) {}

    public function getTopDenseCountries(int $limit): array {
        $countries = $this->repository->fetchAll();

        $mapped = collect($countries)
            ->filter(fn($c) => isset($c['area'], $c['population']) && $c['area'] > 0)
            ->map(fn($c) => new CountryDTO(
                $c['name']['common'] ?? 'Unknown',
                $c['area'],
                $c['population'],
                $c['population'] / $c['area']
            ))
            ->sortByDesc('density')
            ->take($limit)
            ->values()
            ->all();

        return $mapped;
    }
}