// I still dont know why i needed this express
const express = require('express');
const app = express();
//body parser is where we used to pass data from flutter to node so we can either add or delete to database
const bodyParser = require("body-parser");
// this is needed if our database is mysql
const mysql = require('mysql');
// setting up connection to remote or localhost database
const pool = mysql.createPool({
    connectionLimit: 10,
    host: 'localhost',
    user: 'root',
    password: '0505',
    database: 'viral.com'
});

const server = app.listen(3000, () => {
    console.log('server started')
});
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())

app.post('/api/patient', function (req, res) {
    pool.query('SELECT * from patient_details', function (error, results, fields) {
        if (error) {
            console.log(results);
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
app.post('/api/patient/remove', function (req, res) {
    var sql = " DELETE FROM `patient_details` WHERE `patient_details`.`id` = ? ";
    pool.query(sql, [req.body.id], function (error, results, fields) {
        if (error) {
            console.log(results);
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
