const express = require("express");
const hbs = require("hbs");
const wax = require("wax-on");
const mysql = require("mysql2/promise");

let app = express();
app.set("view engine", "hbs");
app.use(express.static("public"));
wax.on(hbs.handlebars);
wax.setLayoutPath("./views/layouts");

app.use(express.urlencoded({ extended: false }));

async function main() {
    // create a SQL connection
    const connection = await mysql.createConnection({
        // host is usually is the web address of the DB or (more commonly) an IP address
        'host': 'localhost',
        'user': 'root',
        'database': 'sakila'
    });

    app.get('/actors', async (req,res)=>{
        let [actors] = await connection.execute("SELECT * FROM actor");
        res.render('actors', {
            'actors': actors
        })
    })

    app.get('/actors/create', async(req,res)=>{
        res.render('actor_create');
    })

    app.post('/actors/create', async(req,res)=>{
        let {first_name, last_name} = req.body;
        // instead of:
        // let first_name = req.body.first_name;
        // let last_name = req.body.last_name;

        // use prepared statements to insert the actor
        let query = `insert into actor (first_name, last_name) VALUES (?,?)`;
        await connection.execute(query, [first_name, last_name]);
        res.redirect('/actors')
    })

    app.get('/actors/:actor_id/update', async(req,res)=>{
        // 1. retrieve the actor that we want to update
        let query = "SELECT * FROM actor WHERE actor_id = ?";
        let [actors] = await connection.execute(query, [req.params.actor_id]);
        let actor = actors[0];

        // 2. render out the form with the actor's data prefilled in
        res.render('actor_update',{
            'actor': actor
        })

    })

    app.post('/actors/:actor_id/update', async(req,res)=>{
        //1 .read in the new first name and last name
        let {first_name, last_name} = req.body;

        const query = "UPDATE actor SET first_name=?, last_name = ? where actor_id = ?";
        await connection.execute(query, [first_name, last_name, req.params.actor_id]);
        res.redirect('/actors');

    })
}

main();

require("handlebars-helpers")({
  handlebars: hbs.handlebars,
});

// ROUTES BEGIN HERE

app.listen(3000, () => {
  console.log("Server started");
});