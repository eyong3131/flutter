// express and cors enable remote database access
const express = require('express');
const cors = require('cors');
const app = express();
//body parser is where we used to pass data from flutter to node so we can either add or delete to database
const bodyParser = require("body-parser");
// this is needed if our database is mysql
const mysql = require('mysql');
// setting up connection to remote or localhost database
const pool = mysql.createPool({
    connectionLimit: 10,
    host: '162.241.216.80',
    user: 'jpdzalmy_eyong',
    password: 'b7hAgm_]M?74',
    database: 'jpdzalmy_rebago_db'
});

const server = app.listen(3306, () => {
    console.log('server started')
});
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

app.post('/api/hash_test', function (req, res) {
    pool.query('SELECT * FROM jpdzalmy_rebago_db.hash_test', function (error, results, fields) {
        if (error) {
            //console.log(results);
            res.status(500).json({ error: error });
        } else {
            for (let index = 0; index < results.length; index++) {
                const element = results[index];
                console.log(element);
            }
            res.status(200).json(results);
        };
    });
})