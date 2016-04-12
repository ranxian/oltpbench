/******************************************************************************
 *  Copyright 2015 by OLTPBenchmark Project                                   *
 *                                                                            *
 *  Licensed under the Apache License, Version 2.0 (the "License");           *
 *  you may not use this file except in compliance with the License.          *
 *  You may obtain a copy of the License at                                   *
 *                                                                            *
 *    http://www.apache.org/licenses/LICENSE-2.0                              *
 *                                                                            *
 *  Unless required by applicable law or agreed to in writing, software       *
 *  distributed under the License is distributed on an "AS IS" BASIS,         *
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  *
 *  See the License for the specific language governing permissions and       *
 *  limitations under the License.                                            *
 ******************************************************************************/

package com.oltpbenchmark.benchmarks.ycsb.procedures;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.List;

import com.oltpbenchmark.api.Procedure;
import com.oltpbenchmark.api.SQLStmt;

public class MultipleRecord extends Procedure{
    public final SQLStmt readStmt = new SQLStmt(
        "SELECT * FROM \"USERTABLE\" WHERE YCSB_KEY=?"
    );

    public final SQLStmt updateAllStmt = new SQLStmt(
        "UPDATE \"USERTABLE\" SET FIELD1=?,FIELD2=?,FIELD3=?,FIELD4=?,FIELD5=?," +
        "FIELD6=?,FIELD7=?,FIELD8=?,FIELD9=?,FIELD10=? WHERE YCSB_KEY=?"
    );

    public void run(Connection conn, List<Integer> readKeyname, List<Map<Integer,String>> readResults, List<Integer> updateKeyname, List<Map<Integer, String>> updateVals) throws SQLException {
        assert(readKeyname.size() == readResults.size());
        assert(updateKeyname.size() == updateVals.size());

        PreparedStatement stmt;
        for (int i = 0; i < readKeyname.size(); ++i) {
            stmt = this.getPreparedStatement(conn, readStmt);
            stmt.setInt(1, readKeyname.get(i));
            ResultSet r = stmt.executeQuery();
            Map<Integer, String> results = new HashMap<Integer, String>();
            while (r.next()) {
                for (int k = 1; k < 11; k++)
                    results.put(k, r.getString(k));
            }
            readResults.add(results);
            r.close();
        }

        for (int i = 0; i < updateKeyname.size(); ++i) {
            stmt= this.getPreparedStatement(conn, updateAllStmt);
            stmt.setInt(11, updateKeyname.get(i));

            for(Entry<Integer, String> s:updateVals.get(i).entrySet())
            {
                stmt.setString(s.getKey(), s.getValue());
            }
            stmt.executeUpdate();
        }

    }

}
