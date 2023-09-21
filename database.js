// get the client
import mysql from 'mysql2';

// create the connection to database
export const connection = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'root',
  database: 'MusicBase',
  password: 'Dadihjem12321!',
  multipleStatements: true
});

// simple query
connection.query(
  'SELECT * FROM `Artist`',
  function(err, results, fields) {
    console.log(results); // results contains rows returned by server
    console.log(fields); // fields contains extra meta data about results, if available
  }
);
