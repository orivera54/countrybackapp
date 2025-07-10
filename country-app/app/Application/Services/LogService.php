<?php
namespace App\Application\Services;

use App\Infrastructure\Persistence\LogUseApp;
use Illuminate\Support\Carbon;

class LogService {
    public function storeLog(string $username, int $count, array $details): void {
        LogUseApp::create([
            'username' => $username,
            'request_timestamp' => Carbon::now(),
            'num_countries_returned' => $count,
            'countries_details' => json_encode($details)
        ]);
    }

    public function getLogs(): array {
        return LogUseApp::all()->toArray();
    }
}
