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
package org.apache.joshua.subsample;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;

import org.apache.joshua.corpus.BasicPhrase;

/**
 * Wrapper class to read in each line as a BasicPhrase.
 * 
 * @author UMD (Jimmy Lin, Chris Dyer, et al.)
 * @author wren ng thornton wren@users.sourceforge.net
 * @version $LastChangedDate$
 */
public class PhraseReader extends BufferedReader {
  private byte language;

  public PhraseReader(Reader r, byte language) {
    super(r);
    this.language = language;
  }

  public BasicPhrase readPhrase() throws IOException {
    String line = super.readLine();
    return (line == null ? null : new BasicPhrase(this.language, line));
  }
}