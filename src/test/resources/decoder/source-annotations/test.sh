#!/bin/bash
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Tests the language model code that uses the source-side projection instead of the word itself.
# When translating a word, if there is a source-side annotation of the label "class", and
# -source-annotations was added to the invocation, the LM will use that source-side class instead
# of the translated word.

set -u

cat input.txt | $JOSHUA/bin/joshua-decoder -threads 1 -c joshua.config > output 2> log
cat input.txt | $JOSHUA/bin/joshua-decoder -threads 1 -c joshua.config -source-annotations >> output 2>> log

# Compare
diff -u output output.gold > diff

if [ $? -eq 0 ]; then
  rm -f diff output log output.scores
  exit 0
else
  exit 1
fi