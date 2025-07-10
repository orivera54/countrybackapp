<?php

return [
    'route' => [
        'uri' => '/graphql',
        'middleware' => ['web'],
    ],

    'schema' => [
        'register' => base_path('graphql/schema.graphql'),
    ],

    'namespaces' => [
        'queries' => 'App\\GraphQL\\Resolvers',
    ],
];
