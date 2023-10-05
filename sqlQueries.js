// sqlQueries.js

// Define SQL queries for Artists
export const getAllArtists = () => {
    return 'SELECT * FROM `artists`';
  };
  
  export const getArtistById = (id) => {
    return 'SELECT * FROM `artists` WHERE artist_id = ?';
  };
  
  export const createArtist = () => {
    return `
      INSERT INTO artists (name, birthdate, active_since, genres, labels, website, short_description, image)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?);
    `;
  };
  
  export const updateArtist = () => {
    return `
      UPDATE Artists
      SET name=?, birthdate=?, active_since=?, genres=?, labels=?, website=?, short_description=?, image=?
      WHERE artist_id=?
    `;
  };
  
  export const deleteArtist = () => {
    return 'DELETE FROM Artists WHERE artist_id=?';
  };
  
  // Define SQL queries for Albums
  export const getAllAlbums = () => {
    return 'SELECT album_name, a.name, num_songs, album_id, a.artist_id FROM `albums` JOIN `artists` a ON albums.artist_id = a.artist_id;';
  };
  
  export const getAlbumById = (id) => {
    return 'SELECT * FROM `albums` WHERE album_id = ?';
  };

  export const getAlbumByName = (albumName => {
    return 'SELECT album_name, a.name, num_songs, album_id, a.artist_id FROM `albums` JOIN `artists` a ON albums.artist_id = a.artist_id WHERE album_name = ?;';
  })

  export const getAlbumByArtist = (artistName) => {
    return 'SELECT album_name, a.name, num_songs, album_id, a.artist_id FROM `albums` JOIN `artists` a ON albums.artist_id = a.artist_id WHERE a.name = ?;';
  };
  
  export const createAlbum = () => {
    return `
      INSERT INTO albums (album_name, artist_id, release_year, num_songs, description)
      VALUES (?, ?, ?, ?, ?);
    `;
  };
  
  export const updateAlbum = () => {
    return `
      UPDATE albums
      SET album_name=?, artist_id=?, release_year=?, num_songs=?, description=?
      WHERE album_id=?
    `;
  };
  
  export const deleteAlbum = () => {
    return 'DELETE FROM albums WHERE album_id=?';
  };
  
  // Define SQL queries for Tracks
  export const getAllTracks = () => {
    return 'SELECT * FROM `tracks`';
  };
  
  export const getTrackById = (id) => {
    return 'SELECT * FROM `tracks` WHERE track_id = ?';
  };
  
  export const createTrack = () => {
    return `
      INSERT INTO tracks (track_name, artist_id, album_id)
      VALUES (?, ?, ?);
    `;
  };
  
  export const updateTrack = () => {
    return `
      UPDATE tracks
      SET track_name=?, artist_id=?, album_id=?
      WHERE track_id=?
    `;
  };
  
  export const deleteTrack = () => {
    return 'DELETE FROM tracks WHERE track_id=?';
  };
  