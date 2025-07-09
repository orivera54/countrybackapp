<?php

namespace App\DTOs;

class CountryDTO {
    public function __construct(
        public string $name,
        public float $area,
        public int $population,
        public float $density
    ) {}
}

