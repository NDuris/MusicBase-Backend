import express from "express";
import cors from "cors";
import { connection } from './database.js';

const app = express();
const port = process.env.PORT || 3333;

app.use(express.json());
app.use(cors());

app.get("/", (request, response) => {
    response.send("Node.js MusicBase REST API 🎉");
});

// READ all artists
app.get("/artists", (request, response) => {
    const query = 'SELECT * FROM `Artist`';

    connection.query(query, (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// READ one artist
app.get("/artists/:id", (request, response) => {
    const id = parseInt(request.params.id);
    const query = 'SELECT * FROM `Artist` WHERE artist_id = ?';

    connection.query(query, [id], (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results[0]);
    });
});

// CREATE artist
app.post("/artists", (request, response) => {
    const newArtist = request.body;
    const insertArtistQuery = `
    INSERT INTO Artist (name, birthdate, active_since, genres, labels, website, short_description, image)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?);
    `;

    const values = [
        newArtist.name,
        newArtist.birthdate,
        newArtist.activeSince,
        newArtist.genres,
        newArtist.labels,
        newArtist.website,
        newArtist.short_description,
        newArtist.image
    ];

    connection.query(insertArtistQuery, values, (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// UPDATE artist
app.put("/artists/:id", (request, response) => {
    const id = parseInt(request.params.id);
    const body = request.body;

    const updateArtistQuery = `
    UPDATE Artist
    SET name=?, birthdate=?, active_since=?, genres=?, labels=?, website=?, short_description=?, image=?
    WHERE artist_id=?
    `;

    const values = [
        body.name,
        body.birthdate,
        body.activeSince,
        body.genres,
        body.labels,
        body.website,
        body.short_description,
        body.image,
        id
    ];

    connection.query(updateArtistQuery, values, (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// DELETE artist
app.delete("/artists/:id", (request, response) => {
    const id = parseInt(request.params.id);
    const deleteArtistQuery = `
    DELETE FROM Artist WHERE artist_id=?
    `;

    connection.query(deleteArtistQuery, [id], (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// READ all tracks
app.get("/tracks", (request, response) => {
    const query = 'SELECT * FROM `Track`';

    connection.query(query, (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// READ one track
app.get("/tracks/:id", (request, response) => {
    const id = parseInt(request.params.id);
    const query = 'SELECT * FROM `Track` WHERE track_id = ?';

    connection.query(query, [id], (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results[0]);
    });
});

// CREATE track
app.post("/tracks", (request, response) => {
    const newTrack = request.body;
    const insertTrackQuery = `
    INSERT INTO Track (name, artist_id, album_id)
    VALUES (?, ?, ?);
    `;

    const values = [
        newTrack.name,
        newTrack.artist_id,
        newTrack.album_id
    ];

    connection.query(insertTrackQuery, values, (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// UPDATE track
app.put("/tracks/:id", (request, response) => {
    const id = parseInt(request.params.id);
    const body = request.body;

    const updateTrackQuery = `
    UPDATE Track
    SET name=?, artist_id=?, album_id=?
    WHERE track_id=?
    `;

    const values = [
        body.name,
        body.artist_id,
        body.album_id,
        id
    ];

    connection.query(updateTrackQuery, values, (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// DELETE track
app.delete("/tracks/:id", (request, response) => {
    const id = parseInt(request.params.id);
    const deleteTrackQuery = `
    DELETE FROM Track WHERE track_id=?
    `;

    connection.query(deleteTrackQuery, [id], (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// READ all albums
app.get("/albums", (request, response) => {
    const query = 'SELECT * FROM `Album`';

    connection.query(query, (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// READ one album
app.get("/albums/:id", (request, response) => {
    const id = parseInt(request.params.id);
    const query = 'SELECT * FROM `Album` WHERE album_id = ?';

    connection.query(query, [id], (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results[0]);
    });
});

// CREATE album
app.post("/albums", (request, response) => {
    const newAlbum = request.body;
    const insertAlbumQuery = `
    INSERT INTO Album (album_name, artist_id, release_year, num_songs, description)
    VALUES (?, ?, ?, ?, ?);
    `;

    const values = [
        newAlbum.album_name,
        newAlbum.artist_id,
        newAlbum.release_year,
        newAlbum.num_songs,
        newAlbum.description
    ];

    connection.query(insertAlbumQuery, values, (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// UPDATE album
app.put("/albums/:id", (request, response) => {
    const id = parseInt(request.params.id);
    const body = request.body;

    const updateAlbumQuery = `
    UPDATE Album
    SET album_name=?, artist_id=?, release_year=?, num_songs=?, description=?
    WHERE album_id=?
    `;

    const values = [
        body.album_name,
        body.artist_id,
        body.release_year,
        body.num_songs,
        body.description,
        id
    ];

    connection.query(updateAlbumQuery, values, (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

// DELETE album
app.delete("/albums/:id", (request, response) => {
    const id = parseInt(request.params.id);
    const deleteAlbumQuery = `
    DELETE FROM Album WHERE album_id=?
    `;

    connection.query(deleteAlbumQuery, [id], (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});

app.listen(port, () => {
    console.log(`App listening on port ${port}`);
    console.log(`App listening on http://localhost:${port}`);
    console.log(`Artists Endpoint: http://localhost:${port}/artists`);
    console.log(`Tracks Endpoint: http://localhost:${port}/tracks`);
    console.log(`Albums Endpoint: http://localhost:${port}/albums`);
});
