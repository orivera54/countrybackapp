<?php

return [
    'route' => [
            'uri' => '/graphql',
            'middleware' => ['api'],
],


    'schema' => [
        'register' => base_path('graphql/schema.graphql'),
    ],

    'namespaces' => [
        'queries' => 'App\\GraphQL\\Resolvers',
    ],
];
