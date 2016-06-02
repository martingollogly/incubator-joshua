/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.joshua.corpus.syntax;

import java.util.Collection;

public interface SyntaxTree {

  public Collection<Integer> getConstituentLabels(int from, int to);

  public Collection<Integer> getConcatenatedLabels(int from, int to);

  public Collection<Integer> getCcgLabels(int from, int to);

  public int[] getTerminals();

  public int[] getTerminals(int from, int to);
}