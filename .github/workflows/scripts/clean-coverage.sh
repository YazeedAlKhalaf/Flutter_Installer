#!/bin/bash

PROJECT_COVERAGE=./coverage/lcov.info

lcov --remove ${PROJECT_COVERAGE} -o ${PROJECT_COVERAGE} \
    '*.gr.dart' \
    "*.g.dart"