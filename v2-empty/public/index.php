<?php
require __DIR__ . '/../vendor/autoload.php';

$app = new \Slim\Slim();
$app->get('/', function () use ($app) {
    $app->response->setBody("Hello World.");
});
$app->run();
