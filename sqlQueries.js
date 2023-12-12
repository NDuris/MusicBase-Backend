// Define SQL queries for Artists
export const getAllArtists = () => {
    return 'SELECT * FROM Artists';
  };
  
  export const getArtistById = (id) => {
    return 'SELECT * FROM Artists WHERE artist_id = ?';
  };
  
  export const createArtist = () => {
    return `
      INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
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
    return 'SELECT album_name, a.name, num_songs, album_id, a.artist_id FROM Albums JOIN Artists a ON Albums.artist_id = a.artist_id';
  };
  
  export const getAlbumById = (id) => {
    return 'SELECT * FROM Albums WHERE album_id = ?';
  };
  
  export const getAlbumByName = (albumName) => {
    return 'SELECT album_name, a.name, num_songs, album_id, a.artist_id FROM Albums JOIN Artists a ON Albums.artist_id = a.artist_id WHERE album_name = ?';
  };
  
  export const getAlbumByArtist = (artistName) => {
    return 'SELECT album_name, a.name, num_songs, album_id, a.artist_id FROM Albums JOIN Artists a ON Albums.artist_id = a.artist_id WHERE a.name = ?';
  };
  
  export const createAlbum = () => {
    return `
      INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
      VALUES (?, ?, ?, ?, ?);
    `;
  };
  
  export const updateAlbum = () => {
    return `
      UPDATE Albums
      SET album_name=?, artist_id=?, release_year=?, num_songs=?, description=?
      WHERE album_id=?
    `;
  };
  
  export const deleteAlbum = () => {
    return 'DELETE FROM Albums WHERE album_id=?';
  };
  
  // Define SQL queries for Tracks
  export const getAllTracks = () => {
    return 'SELECT T.*, A.name AS artist_name FROM Tracks T LEFT JOIN Track_Artist TA ON T.track_id = TA.track_id LEFT JOIN Artists A ON TA.artist_id = A.artist_id';
  };
  
  export const getTrackById = (id) => {
    return 'SELECT T.*, A.name AS artist_name FROM Tracks T LEFT JOIN Track_Artist TA ON T.track_id = TA.track_id LEFT JOIN Artists A ON TA.artist_id = A.artist_id WHERE T.track_id = ?';
  }
  
  
  export const createTrack = () => {
    return `
      CALL InsertNewTrack(?, ?, ?);
    `;
  };
  
  export const updateTrack = () => {
    return `
      UPDATE Tracks
      SET track_name=?, album_id=?
      WHERE track_id=?
    `;
  };
  
  export const deleteTrack = () => {
    return 'DELETE FROM Tracks WHERE track_id=?';
  };
  