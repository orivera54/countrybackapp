<?php

namespace App\Infrastructure\Persistence;

use Illuminate\Database\Eloquent\Model;

class LogUseApp extends Model {
    protected $table = 'log_use_app';
    protected $fillable = ['username', 'request_timestamp', 'num_countries_returned', 'countries_details'];
}
