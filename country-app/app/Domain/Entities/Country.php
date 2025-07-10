<?php

namespace App\Domain\Entities;

class Country {
    public string $name;
    public float $area;
    public int $population;
    public float $density;

    public function __construct(string $name, float $area, int $population) {
        $this->name = $name;
        $this->area = $area;
        $this->population = $population;
        $this->density = $area > 0 ? $population / $area : 0;
    }
}
