-- SETUP DATBASE
CREATE DATABASE MusicBase;

USE MusicBase;

-- Create the Artist table
CREATE TABLE Artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birthdate VARCHAR(255),
    active_since VARCHAR(255),
    genres VARCHAR(255),
    labels VARCHAR(255),
    website VARCHAR(255),
    short_description TEXT,
    image VARCHAR(255)
);

-- Create the Album table with a foreign key reference to Artist
CREATE TABLE Albums (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    album_name VARCHAR(255) NOT NULL,
    artist_id INT,
    release_year VARCHAR(255),
    num_songs VARCHAR(255),
    description TEXT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);


-- Create the Song table with foreign key references to Album and Artist
CREATE TABLE Tracks (
    track_id INT AUTO_INCREMENT PRIMARY KEY,
    track_name VARCHAR(255) NOT NULL,
    album_id INT,
    artist_id INT,
    FOREIGN KEY (album_id) REFERENCES albums(album_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

-- TRIGGERS
-- Trigger to delete albums and tracks where this artist is the main person.
DELIMITER //

CREATE TRIGGER DeleteArtistCascade
BEFORE DELETE ON Artists FOR EACH ROW
BEGIN
    -- Delete related tracks
    DELETE FROM Tracks WHERE artist_id = OLD.artist_id;

    -- Delete related albums
    DELETE FROM Albums WHERE artist_id = OLD.artist_id;
END;
//

DELIMITER ;


DELIMITER //

CREATE TRIGGER CreateArtistIfNotExistsBeforeAlbumInsert
BEFORE INSERT ON Albums FOR EACH ROW
BEGIN
    DECLARE artist_id INT;

    -- Check if the artist exists
    SELECT artist_id INTO artist_id FROM Artists WHERE Artists.name = NEW.artist_name;

    -- If the artist doesn't exist, create a new artist
    IF artist_id IS NULL THEN
        INSERT INTO Artists (name) VALUES (NEW.artist_name);
        SET artist_id = LAST_INSERT_ID();
    END IF;

    -- Set the artist_id for the album
    SET NEW.artist_id = artist_id;
END;
//

DELIMITER ;


-- Insert Artist 1
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('John Lennon', 'October 9, 1940', '1957', '["Rock", "Pop"]', '["Apple Records"]', 'https://www.johnlennon.com/', 'Legendary musician, singer, and songwriter.', 'https://example.com/john-lennon.jpg');

-- Insert Artist 2
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('David Bowie', 'January 8, 1947', '1962', '["Rock", "Pop"]', '["RCA Records"]', 'https://www.davidbowie.com/', 'Iconic singer-songwriter and actor.', 'https://example.com/david-bowie.jpg');

-- Insert Artist 3
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('Adele', 'May 5, 1988', '2006', '["Pop", "Soul"]', '["XL Recordings"]', 'https://www.adele.com/', 'Grammy-winning singer and songwriter.', 'https://example.com/adele.jpg');

-- Insert Artist 4
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('Elton John', 'March 25, 1947', '1962', '["Rock", "Pop"]', '["Rocket Records"]', 'https://www.eltonjohn.com/', 'Legendary singer, pianist, and composer.', 'https://example.com/elton-john.jpg');

-- Insert Artist 5
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('Bob Marley', 'February 6, 1945', '1962', '["Reggae"]', '["Island Records"]', 'https://www.bobmarley.com/', 'Reggae legend and songwriter.', 'https://example.com/bob-marley.jpg');

-- Insert Artist 6
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('Madonna', 'August 16, 1958', '1978', '["Pop", "Dance"]', '["Sire Records"]', 'https://www.madonna.com/', 'Queen of Pop and cultural icon.', 'https://example.com/madonna.jpg');

-- Insert Artist 7
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('Eminem', 'October 17, 1972', '1992', '["Hip-Hop", "Rap"]', '["Shady Records"]', 'https://www.eminem.com/', 'Rap superstar and songwriter.', 'https://example.com/eminem.jpg');

-- Insert Artist 8
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('Taylor Swift', 'December 13, 1989', '2004', '["Country", "Pop"]', '["Big Machine Records"]', 'https://www.taylorswift.com/', 'Award-winning singer-songwriter.', 'https://example.com/michael-jackson.jpg');

-- Insert Artist 9
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('Michael Jackson', 'August 29, 1958', '1964', '["Pop", "R&B"]', '["Epic Records"]', 'https://www.michaeljackson.com/', 'King of Pop and global icon.', 'https://example.com/michael-jackson.jpg');

-- Insert Artist 10
INSERT INTO Artists (name, birthdate, active_since, genres, labels, website, short_description, image)
VALUES
    ('Artist 10 Name', 'Artist 10 Birthdate', 'Artist 10 Active Since', '["Genre 1", "Genre 2"]', '["Label 1", "Label 2"]', 'https://example.com/artist-10-website/', 'Artist 10 Description', 'https://example.com/artist-10-image.jpg');

-- Insert statements for John Lennon's albums
-- Album 1: Imagine
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Imagine', 1, '1971', 10, 'Album by John Lennon');

-- Get the auto-generated album_id for the inserted album
SET @album_id_3 = LAST_INSERT_ID();

-- Insert statements for tracks on "Imagine" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Imagine', @album_id_3, 1),
    ('Crippled Inside', @album_id_3, 1),
    ('Jealous Guy', @album_id_3, 1),
    ('It\'s So Hard', @album_id_3, 1),
    ('I Don\'t Wanna Be a Soldier', @album_id_3, 1),
    ('Gimme Some Truth', @album_id_3, 1),
    ('Oh My Love', @album_id_3, 1),
    ('How Do You Sleep?', @album_id_3, 1),
    ('How?', @album_id_3, 1),
    ('Oh Yoko!', @album_id_3, 1);

-- Album 2: Double Fantasy
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Double Fantasy', 1, '1980', 14, 'Album by John Lennon');

-- Get the auto-generated album_id for the inserted album
SET @album_id_4 = LAST_INSERT_ID();

-- Insert statements for tracks on "Double Fantasy" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('(Just Like) Starting Over', @album_id_4, 1),
    ('Kiss Kiss Kiss', @album_id_4, 1),
    ('Cleanup Time', @album_id_4, 1),
    ('Give Me Something', @album_id_4, 1),
    ('I\'m Losing You', @album_id_4, 1),
    ('I\'m Moving On', @album_id_4, 1),
    ('Beautiful Boy (Darling Boy)', @album_id_4, 1),
    ('Watching the Wheels', @album_id_4, 1),
    ('Yes, I\'m Your Angel', @album_id_4, 1),
    ('Woman', @album_id_4, 1),
    ('Beautiful Boys', @album_id_4, 1),
    ('Dear Yoko', @album_id_4, 1),
    ('Every Man Has a Woman Who Loves Him', @album_id_4, 1),
    ('Hard Times Are Over', @album_id_4, 1);

-- Insert statements for David Bowie's albums
-- Album 1: The Rise and Fall of Ziggy Stardust and the Spiders from Mars
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('The Rise and Fall of Ziggy Stardust and the Spiders from Mars', 2, '1972', 11, 'Album by David Bowie');

-- Get the auto-generated album_id for the inserted album
SET @album_id_5 = LAST_INSERT_ID();

-- Insert statements for tracks on "The Rise and Fall of Ziggy Stardust and the Spiders from Mars" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Five Years', @album_id_5, 2),
    ('Soul Love', @album_id_5, 2),
    ('Moonage Daydream', @album_id_5, 2),
    ('Starman', @album_id_5, 2),
    ('It Ain\'t Easy', @album_id_5, 2),
    ('Lady Stardust', @album_id_5, 2),
    ('Star', @album_id_5, 2),
    ('Hang on to Yourself', @album_id_5, 2),
    ('Ziggy Stardust', @album_id_5, 2),
    ('Suffragette City', @album_id_5, 2),
    ('Rock \'n\' Roll Suicide', @album_id_5, 2);

-- Album 2: Heroes
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Heroes', 2, '1977', 10, 'Album by David Bowie');

-- Get the auto-generated album_id for the inserted album
SET @album_id_6 = LAST_INSERT_ID();

-- Insert statements for tracks on "Heroes" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Beauty and the Beast', @album_id_6, 2),
    ('Joe the Lion', @album_id_6, 2),
    ('"Heroes"', @album_id_6, 2),
    ('Sons of the Silent Age', @album_id_6, 2),
    ('Blackout', @album_id_6, 2),
    ('V-2 Schneider', @album_id_6, 2),
    ('Sense of Doubt', @album_id_6, 2),
    ('Moss Garden', @album_id_6, 2),
    ('Neuköln', @album_id_6, 2),
    ('The Secret Life of Arabia', @album_id_6, 2);

-- Insert statements for Adele's albums
-- Album 1: 19
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('19', 3, '2008', 12, 'Debut Studio Album by Adele');

-- Get the auto-generated album_id for the inserted album
SET @album_id_7 = LAST_INSERT_ID();

-- Insert statements for tracks on "19" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Hometown Glory', @album_id_7, 3),
    ('I\'ll Be Waiting', @album_id_7, 3),
    ('Don\'t You Remember', @album_id_7, 3),
    ('Turning Tables', @album_id_7, 3),
    ('Set Fire to the Rain', @album_id_7, 3),
    ('If It Hadn\'t Been for Love', @album_id_7, 3),
    ('My Same', @album_id_7, 3),
    ('Take It All', @album_id_7, 3),
    ('Rumour Has It', @album_id_7, 3),
    ('Right as Rain', @album_id_7, 3),
    ('One and Only', @album_id_7, 3),
    ('Lovesong', @album_id_7, 3);

-- Album 2: 21
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('21', 3, '2011', 11, 'Second Studio Album by Adele');

-- Get the auto-generated album_id for the inserted album
SET @album_id_8 = LAST_INSERT_ID();

-- Insert statements for tracks on "21" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Rolling in the Deep', @album_id_8, 3),
    ('Rumour Has It', @album_id_8, 3),
    ('Turning Tables', @album_id_8, 3),
    ('Don\'t You Remember', @album_id_8, 3),
    ('Set Fire to the Rain', @album_id_8, 3),
    ('He Won\'t Go', @album_id_8, 3),
    ('Take It All', @album_id_8, 3),
    ('I\'ll Be Waiting', @album_id_8, 3),
    ('One and Only', @album_id_8, 3),
    ('Lovesong', @album_id_8, 3),
    ('Someone Like You', @album_id_8, 3);

-- Insert statements for Elton John's albums
-- Album 1: Goodbye Yellow Brick Road
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Goodbye Yellow Brick Road', 4, '1973', 17, 'Album by Elton John');

-- Get the auto-generated album_id for the inserted album
SET @album_id_9 = LAST_INSERT_ID();

-- Insert statements for tracks on "Goodbye Yellow Brick Road" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Funeral for a Friend/Love Lies Bleeding', @album_id_9, 4),
    ('Candle in the Wind', @album_id_9, 4),
    ('Bennie and the Jets', @album_id_9, 4),
    ('Goodbye Yellow Brick Road', @album_id_9, 4),
    ('This Song Has No Title', @album_id_9, 4),
    ('Grey Seal', @album_id_9, 4),
    ('Jamaica Jerk-Off', @album_id_9, 4),
    ('I\'ve Seen That Movie Too', @album_id_9, 4),
    ('Sweet Painted Lady', @album_id_9, 4),
    ('The Ballad of Danny Bailey (1909–34)', @album_id_9, 4),
    ('Dirty Little Girl', @album_id_9, 4),
    ('All the Girls Love Alice', @album_id_9, 4),
    ('Your Sister Can\'t Twist (But She Can Rock \'n Roll)', @album_id_9, 4),
    ('Saturday Night\'s Alright for Fighting', @album_id_9, 4),
    ('Roy Rogers', @album_id_9, 4),
    ('Social Disease', @album_id_9, 4),
    ('Harmony', @album_id_9, 4);

-- Album 2: Captain Fantastic and the Brown Dirt Cowboy
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Captain Fantastic and the Brown Dirt Cowboy', 4, '1975', 10, 'Album by Elton John');

-- Get the auto-generated album_id for the inserted album
SET @album_id_10 = LAST_INSERT_ID();

-- Insert statements for tracks on "Captain Fantastic and the Brown Dirt Cowboy" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Captain Fantastic and the Brown Dirt Cowboy', @album_id_10, 4),
    ('Tower of Babel', @album_id_10, 4),
    ('Bitter Fingers', @album_id_10, 4),
    ('Tell Me When the Whistle Blows', @album_id_10, 4),
    ('Someone Saved My Life Tonight', @album_id_10, 4),
    ('(Gotta Get a) Meal Ticket', @album_id_10, 4),
    ('Better Off Dead', @album_id_10, 4),
    ('Writing', @album_id_10, 4),
    ('We All Fall in Love Sometimes', @album_id_10, 4),
    ('Curtains', @album_id_10, 4);

-- Insert statements for Bob Marley's albums
-- Album 1: Legend
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Legend', 5, '1984', 14, 'Compilation Album by Bob Marley & The Wailers');

-- Get the auto-generated album_id for the inserted album
SET @album_id_11 = LAST_INSERT_ID();

-- Insert statements for tracks on "Legend" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Is This Love', @album_id_11, 5),
    ('No Woman, No Cry (Live)', @album_id_11, 5),
    ('Could You Be Loved', @album_id_11, 5),
    ('Three Little Birds', @album_id_11, 5),
    ('Buffalo Soldier', @album_id_11, 5),
    ('Get Up, Stand Up', @album_id_11, 5),
    ('Stir It Up', @album_id_11, 5),
    ('One Love/People Get Ready', @album_id_11, 5),
    ('I Shot the Sheriff', @album_id_11, 5),
    ('Waiting in Vain', @album_id_11, 5),
    ('Redemption Song', @album_id_11, 5),
    ('Satisfy My Soul', @album_id_11, 5),
    ('Exodus', @album_id_11, 5),
    ('Jamming', @album_id_11, 5);

-- Album 2: Natty Dread
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Natty Dread', 5, '1974', 9, 'Album by Bob Marley & The Wailers');

-- Get the auto-generated album_id for the inserted album
SET @album_id_12 = LAST_INSERT_ID();

-- Insert statements for tracks on "Natty Dread" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Lively Up Yourself', @album_id_12, 5),
    ('No Woman, No Cry', @album_id_12, 5),
    ('Them Belly Full (But We Hungry)', @album_id_12, 5),
    ('Rebel Music (3 O\'Clock Roadblock)', @album_id_12, 5),
    ('So Jah Seh', @album_id_12, 5),
    ('Natty Dread', @album_id_12, 5),
    ('Bend Down Low', @album_id_12, 5),
    ('Talkin\' Blues', @album_id_12, 5),
    ('Revolution', @album_id_12, 5);

-- Insert statements for Madonna's albums
-- Album 1: Like a Virgin
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Like a Virgin', 6, '1984', 9, 'Album by Madonna');

-- Get the auto-generated album_id for the inserted album
SET @album_id_13 = LAST_INSERT_ID();

-- Insert statements for tracks on "Like a Virgin" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Material Girl', @album_id_13, 6),
    ('Angel', @album_id_13, 6),
    ('Like a Virgin', @album_id_13, 6),
    ('Over and Over', @album_id_13, 6),
    ('Love Don\'t Live Here Anymore', @album_id_13, 6),
    ('Dress You Up', @album_id_13, 6),
    ('Shoo-Bee-Doo', @album_id_13, 6),
    ('Pretender', @album_id_13, 6),
    ('Stay', @album_id_13, 6);

-- Album 2: True Blue
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('True Blue', 6, '1986', 9, 'Album by Madonna');

-- Get the auto-generated album_id for the inserted album
SET @album_id_14 = LAST_INSERT_ID();

-- Insert statements for tracks on "True Blue" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Papa Don\'t Preach', @album_id_14, 6),
    ('Open Your Heart', @album_id_14, 6),
    ('White Heat', @album_id_14, 6),
    ('Live to Tell', @album_id_14, 6),
    ('Where\'s the Party', @album_id_14, 6),
    ('True Blue', @album_id_14, 6),
    ('La Isla Bonita', @album_id_14, 6),
    ('Jimmy Jimmy', @album_id_14, 6),
    ('Love Makes the World Go Round', @album_id_14, 6);


-- Insert statement for "Curtain Call" album by Eminem
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Curtain Call', 7, '2005', 16, 'Greatest Hits Compilation Album by Eminem');

-- Get the auto-generated album_id for the inserted album
SET @album_id_1 = LAST_INSERT_ID();

-- Insert statements for tracks on "Curtain Call" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Intro', @album_id_1, 7),
    ('Fack', @album_id_1, 7),
    ('The Way I Am', @album_id_1, 7),
    ('My Name Is', @album_id_1, 7),
    ('Stan', @album_id_1, 7),
    ('Lose Yourself', @album_id_1, 7),
    ('Shake That', @album_id_1, 7),
    ('Sing for the Moment', @album_id_1, 7),
    ('Without Me', @album_id_1, 7),
    ('Like Toy Soldiers', @album_id_1, 7),
    ('The Real Slim Shady', @album_id_1, 7),
    ('Mockingbird', @album_id_1, 7),
    ('Guilty Conscience', @album_id_1, 7),
    ('Cleanin\' Out My Closet', @album_id_1, 7),
    ('Just Lose It', @album_id_1, 7),
    ('When I\'m Gone', @album_id_1, 7);

-- Insert statement for "Relapse" album by Eminem
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Relapse', 7, '2009', 20, 'Album by Eminem');

-- Get the auto-generated album_id for the inserted album
SET @album_id_2 = LAST_INSERT_ID();

-- Insert statements for tracks on "Relapse" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Dr. West (Skit)', @album_id_2, 7),
    ('3 a.m.', @album_id_2, 7),
    ('My Mom', @album_id_2, 7),
    ('Insane', @album_id_2, 7),
    ('Bagpipes from Baghdad', @album_id_2, 7),
    ('Hello', @album_id_2, 7),
    ('Tonya (Skit)', @album_id_2, 7),
    ('Same Song & Dance', @album_id_2, 7),
    ('We Made You', @album_id_2, 7),
    ('Medicine Ball', @album_id_2, 7),
    ('Paul (Skit)', @album_id_2, 7),
    ('Stay Wide Awake', @album_id_2, 7),
    ('Old Time\'s Sake', @album_id_2, 7),
    ('Must Be the Ganja', @album_id_2, 7),
    ('Mr. Mathers (Skit)', @album_id_2, 7),
    ('Deja Vu', @album_id_2, 7),
    ('Beautiful', @album_id_2, 7),
    ('Crack a Bottle', @album_id_2, 7),
    ('Steve Berman (Skit)', @album_id_2, 7),
    ('Underground', @album_id_2, 7);



-- Insert statements for Taylor Swift's albums
-- Album 1: Fearless
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Fearless', 8, '2008', 13, 'Album by Taylor Swift');

-- Get the auto-generated album_id for the inserted album
SET @album_id_15 = LAST_INSERT_ID();

-- Insert statements for tracks on "Fearless" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Fearless', @album_id_15, 8),
    ('Fifteen', @album_id_15, 8),
    ('Love Story', @album_id_15, 8),
    ('Hey Stephen', @album_id_15, 8),
    ('White Horse', @album_id_15, 8),
    ('You Belong with Me', @album_id_15, 8),
    ('Breathe', @album_id_15, 8),
    ('Change', @album_id_15, 8),
    ('Our Song', @album_id_15, 8),
    ('Teardrops on My Guitar', @album_id_15, 8),
    ('Should\'ve Said No', @album_id_15, 8),
    ('The Way I Loved You', @album_id_15, 8),
    ('Forever & Always', @album_id_15, 8);

-- Album 2: Speak Now
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Speak Now', 8, '2010', 14, 'Album by Taylor Swift');

-- Get the auto-generated album_id for the inserted album
SET @album_id_16 = LAST_INSERT_ID();

-- Insert statements for tracks on "Speak Now" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Mine', @album_id_16, 8),
    ('Sparks Fly', @album_id_16, 8),
    ('Back to December', @album_id_16, 8),
    ('Speak Now', @album_id_16, 8),
    ('Dear John', @album_id_16, 8),
    ('Mean', @album_id_16, 8),
    ('The Story of Us', @album_id_16, 8),
    ('Never Grow Up', @album_id_16, 8),
    ('Enchanted', @album_id_16, 8),
    ('Better Than Revenge', @album_id_16, 8),
    ('Innocent', @album_id_16, 8),
    ('Haunted', @album_id_16, 8),
    ('Last Kiss', @album_id_16, 8),
    ('Long Live', @album_id_16, 8);

-- Insert statements for Michael Jackson's albums
-- Album 1: Thriller
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Thriller', 9, '1982', 9, 'Album by Michael Jackson');

-- Get the auto-generated album_id for the inserted album
SET @album_id_17 = LAST_INSERT_ID();

-- Insert statements for tracks on "Thriller" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Wanna Be Startin\' Somethin\'', @album_id_17, 9),
    ('Baby Be Mine', @album_id_17, 9),
    ('The Girl Is Mine', @album_id_17, 9),
    ('Thriller', @album_id_17, 9),
    ('Beat It', @album_id_17, 9),
    ('Billie Jean', @album_id_17, 9),
    ('Human Nature', @album_id_17, 9),
    ('P.Y.T. (Pretty Young Thing)', @album_id_17, 9),
    ('The Lady in My Life', @album_id_17, 9);

-- Album 2: Bad
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Bad', 9, '1987', 10, 'Album by Michael Jackson');

-- Get the auto-generated album_id for the inserted album
SET @album_id_18 = LAST_INSERT_ID();

-- Insert statements for tracks on "Bad" album
INSERT INTO Tracks (track_name, album_id, artist_id)
VALUES
    ('Bad', @album_id_18, 9),
    ('The Way You Make Me Feel', @album_id_18, 9),
    ('Speed Demon', @album_id_18, 9),
    ('Liberian Girl', @album_id_18, 9),
    ('Just Good Friends', @album_id_18, 9),
    ('Another Part of Me', @album_id_18, 9),
    ('Man in the Mirror', @album_id_18, 9),
    ('I Just Can\'t Stop Loving You', @album_id_18, 9),
    ('Dirty Diana', @album_id_18, 9),
    ('Smooth Criminal', @album_id_18, 9);
