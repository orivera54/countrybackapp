<?php

namespace App\GraphQL\Resolvers;

use App\Application\Services\CountryService;
use App\Application\Services\LogService;

class CountryResolver {
    public function topDensityCountries($_, array $args) {
        $countryService = new CountryService();
        $logService = new LogService();

        $countries = $countryService->getTopByDensity($args['limit']);
        $logService->storeLog($args['username'], count($countries), $countries);
        return $countries;
    }

    public function usageLogs() {
        $logService = new LogService();
        return $logService->getLogs();
    }
}
