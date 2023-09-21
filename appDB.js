import express from "express";
import cors from "cors";
import {connection} from './database.js';
//this is DB

const app = express();
const port = process.env.PORT || 3333;

app.use(cors()); // Enable CORS for all routes
app.use(express.json()); // Parse JSON request bodies

app.get("/", (request, response) => {
    response.send("Node.js MusicBase REST API 🎉");
});

// READ all artists
app.get("/artists", async (request, response) => {
    const query = 'SELECT * FROM `Artist`';
   
    connection.query(query, (error, results) => {
        if (error) {
            console.error(error);
            return;
        }
        
        response.json(results);
    });
});

// READ one artist
app.get("/artists/:id", async (request, response) => {
    const id = parseInt(request.params.id); // tager id fra url'en, så det kan anvendes til at finde den givne bruger med "det" id.
    const query = 'SELECT * FROM `Artist` where artist_id = ' + id;
    
    connection.query(query, (error, results) => {
        if (error) {
            console.error(error);
            return;
        }
        
        response.json(results);
    });
});

// CREATE artist
app.post("/artists", async (request, response) => {
    const newArtist = request.body;

    const insertArtistQuery = `
    INSERT INTO Artist (name, birthdate, active_since, genres, labels, website, short_description, image)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?);
    `;

    const values = [
        newArtist.name,
        newArtist.birthdate,
        newArtist.active_since,
        newArtist.genres,
        newArtist.labels,
        newArtist.website,
        newArtist.short_description,
        newArtist.image
    ];

    connection.query(insertArtistQuery, values, (error, results) => {
        if (error) {
            console.error(error);
            return;
        }

        response.json(results);
    });
});


// UPDATE user
app.put("/artists/:id", async (request, response) => {
    const id = parseInt(request.params.id); // tager id fra url'en, så det kan anvendes til at finde den givne bruger med "det" id.
    const body = request.body;

    const updateArtistQuery = `
    UPDATE Artist
    SET
        name = ?,
        birthdate = ?,
        active_since = ?,
        genres = ?,
        labels = ?,
        website = ?,
        short_description = ?,
        image = ?
    WHERE
        artist_id = ?;
`;

    const values = [
        body.name,
        body.birthdate,
        body.active_since,
        body.genre,
        body.labels,
        body.website,
        body.image,
        body.short_description,
        id
    ];

    connection.query(updateArtistQuery, values, (error, results) => {
        if (error) {
            console.error(error);
            return;
        }

        response.json(results);
    });
});

// DELETE user
app.delete("/artists/:id", async (request, response) => {
    const id = request.params.id; // tager id fra url'en, så det kan anvendes til at finde den givne bruger med "det" id.
    const artists = await getArtistsFromJSON();
    // const newUsers = users.filter(user => user.id !== id);
    const index = artists.findIndex(artist => artist.id === id);
    artists.splice(index, 1);
    fs.writeFile("data1.json", JSON.stringify(artists));
    response.json(artists);
});

app.listen(port, () => {
    console.log(`App listening on port ${port}`);
    console.log(`App listening on http://localhost:${port}`);
    console.log(`Users Endpoint http://localhost:${port}/artists`);
});
