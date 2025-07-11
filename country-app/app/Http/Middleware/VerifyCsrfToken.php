<?php

namespace App\Http\Middleware;

use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as Middleware;

class VerifyCsrfToken extends Middleware
{
    /**
     * Los URIs que deberían ser excluidos de la verificación CSRF.
     *
     * @var array<int, string>
     */
    protected $except = [
        '/graphql',
    ];
}
