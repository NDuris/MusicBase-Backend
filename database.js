// get the client
import mysql from 'mysql2';

// create the connection to database
export const connection = mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'root',
  database: 'musicbase',
  password: 'Dadihjem12321!',
  multipleStatements: true
});
