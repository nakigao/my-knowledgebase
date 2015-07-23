<?php
define('DS', DIRECTORY_SEPARATOR);
$inputFilePath = '.';
$inputFileName = $inputFilePath . DS . 'server_info_master.csv';
$outputFilePath = '.';
$outputFileName = '';
// CSV読み込み
$fileObject = new SplFileObject($inputFileName);
$fileObject->setFlags(SplFileObject::READ_CSV);
$fileObject->setCsvControl("\t");
$loopCount = 1;
// CSVを1行ずつ処理
foreach ($fileObject as $line) {
    if (empty($line[0])) {
        // 空のラインは処理しない
        continue;
    }
    $hostName = strtolower($line[3]);
    $outputFileName = $outputFilePath . DS . $hostName . '_server_info.txt';
    $data = <<< EOM
# STATUS
{$line[0]}

# HW TYPE
{$line[1]}

# HYPER VISOR
{$line[2]}

# HOST
- NAME: {$line[3]}
- SEGMENT: {$line[4]}
- IP: {$line[5]}

# OS
{$line[6]} {$line[7]} {$line[8]}

# CATEGORY
{$line[9]}

# PLACE
{$line[10]}

# TITLE
{$line[11]}

# MODULES
- HTTP: {$line[12]}
- MRTG: {$line[13]}
- WEBALIZER: {$line[14]}

# DNS登録
{$line[15]}

# DETAIL
{$line[16]}

# 担当者
{$line[17]}

# バックアップ方針
{$line[18]}

EOM;
    file_put_contents($outputFileName, $data);
    $loopCount += 1;
}
