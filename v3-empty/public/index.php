<?php
require __DIR__ . '/../vendor/autoload.php';

$config = [
    'settings' => [
        'displayErrorDetails' => true, // set to false in production
        'addContentLengthHeader' => false, // Allow the web server to send the content-length header
 
    ],
];
$app = new \Slim\App($config);

$app->get("/", function ($request, $response, $args) {

    $response->write("Hello World.");

    return $response;
});

// Run!
$app->run();
