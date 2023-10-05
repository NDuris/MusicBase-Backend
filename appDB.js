import express from "express";
import cors from "cors";
import { connection } from './database.js';
import * as sqlQueries from './sqlQueries.js'; // Import the compiled SQL queries

const app = express();
const port = process.env.PORT || 3334;

app.use(express.json());
app.use(cors());

app.get("/", (request, response) => {
  response.send("Node.js MusicBase REST API 🎉");
});

app.get("/search", (request, response) => {
    const searchTerm = request.query.term; // Get the search term from the query parameter
    const searchType = request.query.type; // Get the search type from the query parameter

    // Define SQL queries based on search type (customize these queries as needed)
    // TODO use a switch here (looks nicer)
    let sqlQuery = "";
    if (searchType === "artist") {
        sqlQuery = `
            SELECT * FROM artists
            WHERE name LIKE '%${searchTerm}%' OR genres LIKE '%${searchTerm}%' OR labels LIKE '%${searchTerm}%'`;
        } else if (searchType === "album") {
        sqlQuery = `
            SELECT album_name, a.name, num_songs, album_id, a.artist_id FROM albums
            JOIN artists a ON albums.artist_id = a.artist_id
            WHERE album_name LIKE '%${searchTerm}%' OR release_year LIKE '%${searchTerm}%' OR a.name Like '%${searchTerm}%'`;
        } else if (searchType === "track") {
        sqlQuery = `
            SELECT track_name, a.name, al.album_name, a.artist_id, al.album_id 
            FROM tracks 
                JOIN artists a ON tracks.artist_id = a.artist_id 
                JOIN albums al ON tracks.album_id = al.album_id 
            WHERE track_name LIKE '%${searchTerm}%' 
                OR  al.album_name LIKE '%${searchTerm}%' 
                OR  a.name LIKE '%${searchTerm}%'`;
        }

    // Execute the SQL query with the search term
    connection.query(sqlQuery, [`%${searchTerm}%`, `%${searchTerm}%`], (error, results) => {
        if (error) {
            console.error(error);
            return response.status(500).json({ error: "Internal Server Error" });
        }

        response.json(results);
    });
});


// READ all artists
app.get("/artists", (request, response) => {
  const query = sqlQueries.getAllArtists();

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
  const query = sqlQueries.getArtistById(id);

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
  const query = sqlQueries.createArtist();

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

  connection.query(query, values, (error, results) => {
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
  const query = sqlQueries.updateArtist();

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

  connection.query(query, values, (error, results) => {
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
  const query = sqlQueries.deleteArtist();

  connection.query(query, [id], (error, results) => {
    if (error) {
      console.error(error);
      return response.status(500).json({ error: "Internal Server Error" });
    }

    response.json(results);
  });
});

// READ all albums
app.get("/albums", (request, response) => {
  const query = sqlQueries.getAllAlbums();

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
  const query = sqlQueries.getAlbumById(id);

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
  const query = sqlQueries.createAlbum();

  const values = [
    newAlbum.album_name,
    newAlbum.artist_id,
    newAlbum.release_year,
    newAlbum.num_songs,
    newAlbum.description
  ];

  connection.query(query, values, (error, results) => {
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
  const query = sqlQueries.updateAlbum();

  const values = [
    body.album_name,
    body.artist_id,
    body.release_year,
    body.num_songs,
    body.description,
    id
  ];

  connection.query(query, values, (error, results) => {
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
  const query = sqlQueries.deleteAlbum();

  connection.query(query, [id], (error, results) => {
    if (error) {
      console.error(error);
      return response.status(500).json({ error: "Internal Server Error" });
    }

    response.json(results);
  });
});

// READ all tracks
app.get("/tracks", (request, response) => {
  const query = sqlQueries.getAllTracks();

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
  const query = sqlQueries.getTrackById(id);

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
  const query = sqlQueries.createTrack();

  const values = [
    newTrack.track_name,
    newTrack.artist_id,
    newTrack.album_id
  ];

  connection.query(query, values, (error, results) => {
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
  const query = sqlQueries.updateTrack();

  const values = [
    body.track_name,
    body.artist_id,
    body.album_id,
    id
  ];

  connection.query(query, values, (error, results) => {
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
  const query = sqlQueries.deleteTrack();

  connection.query(query, [id], (error, results) => {
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
