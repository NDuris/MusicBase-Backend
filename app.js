import express from "express";
import fs from "fs/promises";
import cors from "cors";
//this is DB

const app = express();
const port = process.env.PORT || 3333;

app.use(express.json()); // To parse JSON bodies
app.use(cors()); // Enable CORS for all routes

app.get("/", (request, response) => {
    response.send("Node.js MusicBase REST API 🎉");
});

async function getArtistsFromJSON() {
    const data = await fs.readFile("data1.json");
    const artists = JSON.parse(data);
    return artists;
}

// READ all artists
app.get("/artists", async (request, response) => {
    response.json(await getArtistsFromJSON());
});

// READ one artist
app.get("/artists/:id", async (request, response) => {
    const id = parseInt(request.params.id); // tager id fra url'en, så det kan anvendes til at finde den givne bruger med "det" id.
    const artists = await getArtistsFromJSON();
    const artist = artists.find(artist => artist.id === id);
    response.json(artist);
});

// CREATE artist
app.post("/artists", async (request, response) => {
    const newArtist = request.body;
    const artists = await getArtistsFromJSON();
    newArtist.id = artists.length;
    console.log(newArtist);

    artists.push(newArtist);
    fs.writeFile("data1.json", JSON.stringify(artists));
    response.json(artists);
});

// UPDATE user
app.put("/artists/:id", async (request, response) => {
    const id = parseInt(request.params.id); // tager id fra url'en, så det kan anvendes til at finde den givne bruger med "det" id.
    const artists = await getArtistsFromJSON();
    let artistToUpdate = artists.find(artist => artist.id === id);
    const body = request.body;
    artistToUpdate.name = body.name;
    artistToUpdate.birthdate = body.birthdate;
    artistToUpdate.activeSince = body.activeSince;
    artistToUpdate.genre = body.genre;
    artistToUpdate.labels = body.labels;
    artistToUpdate.website = body.website;
    artistToUpdate.image = body.image;
    artistToUpdate.shortDescription = body.shortDescription;
    artistToUpdate.isFavorite = body.isFavorite;

    fs.writeFile("data1.json", JSON.stringify(artists));
    response.json(artists);
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
