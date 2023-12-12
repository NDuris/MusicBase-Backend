
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


-- Create the Song table with a foreign key reference to Album
CREATE TABLE Tracks (
    track_id INT AUTO_INCREMENT PRIMARY KEY,
    track_name VARCHAR(255) NOT NULL,
    album_id INT,
    FOREIGN KEY (album_id) REFERENCES Albums(album_id)
);


-- Create the Track_Artists table to handle many-to-many relationship between Tracks and Artists
CREATE TABLE Track_Artist (
    track_id INT,
    artist_id INT,
    PRIMARY KEY (track_id, artist_id),
    FOREIGN KEY (track_id) REFERENCES Tracks(track_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

DELIMITER //

CREATE PROCEDURE InsertNewTrack(
  IN artist_name_param VARCHAR(255),
  IN album_name_param VARCHAR(255),
  IN track_name_param VARCHAR(255)
)
BEGIN
  DECLARE artist_id INT;
  DECLARE album_id INT;
  DECLARE track_id INT;

  -- Check if the artist exists, and if not, insert the artist
  SELECT artist_id INTO artist_id FROM Artists WHERE Artists.name = artist_name_param;
  IF artist_id IS NULL THEN
    INSERT INTO Artists (name) VALUES (artist_name_param);
    SET artist_id = LAST_INSERT_ID();
  END IF;

  -- Check if the album exists, and if not, insert the album
  SELECT album_id INTO album_id FROM Albums WHERE Albums.album_name = album_name_param;
  IF album_id IS NULL THEN
    INSERT INTO Albums (album_name, num_songs) VALUES (album_name_param, 1);
    SET album_id = LAST_INSERT_ID();
  ELSE
    -- If the album already exists, update the num_songs value
    UPDATE Albums SET num_songs = num_songs + 1 WHERE Albums.album_id = album_id;
  END IF;

  -- Insert the new track
  INSERT INTO Tracks (album_id, track_name) VALUES (album_id, track_name_param);
  SET track_id = LAST_INSERT_ID();

  -- Insert the relationship between the track and the artist
  INSERT INTO Track_Artist (track_id, artist_id) VALUES (track_id, artist_id);
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
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Imagine', @album_id_3),
    ('Crippled Inside', @album_id_3),
    ('Jealous Guy', @album_id_3),
    ('It\'s So Hard', @album_id_3),
    ('I Don\'t Wanna Be a Soldier', @album_id_3),
    ('Gimme Some Truth', @album_id_3),
    ('Oh My Love', @album_id_3),
    ('How Do You Sleep?', @album_id_3),
    ('How?', @album_id_3),
    ('Oh Yoko!', @album_id_3);

-- Album 2: Double Fantasy
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Double Fantasy', 1, '1980', 14, 'Album by John Lennon');

-- Get the auto-generated album_id for the inserted album
SET @album_id_4 = LAST_INSERT_ID();

-- Insert statements for tracks on "Double Fantasy" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('(Just Like) Starting Over', @album_id_4),
    ('Kiss Kiss Kiss', @album_id_4),
    ('Cleanup Time', @album_id_4),
    ('Give Me Something', @album_id_4),
    ('I\'m Losing You', @album_id_4),
    ('I\'m Moving On', @album_id_4),
    ('Beautiful Boy (Darling Boy)', @album_id_4),
    ('Watching the Wheels', @album_id_4),
    ('Yes, I\'m Your Angel', @album_id_4),
    ('Woman', @album_id_4),
    ('Beautiful Boys', @album_id_4),
    ('Dear Yoko', @album_id_4),
    ('Every Man Has a Woman Who Loves Him', @album_id_4),
    ('Hard Times Are Over', @album_id_4);

-- Insert statements for David Bowie's albums
-- Album 1: The Rise and Fall of Ziggy Stardust and the Spiders from Mars
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('The Rise and Fall of Ziggy Stardust and the Spiders from Mars', 2, '1972', 11, 'Album by David Bowie');

-- Get the auto-generated album_id for the inserted album
SET @album_id_5 = LAST_INSERT_ID();

-- Insert statements for tracks on "The Rise and Fall of Ziggy Stardust and the Spiders from Mars" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Five Years', @album_id_5),
    ('Soul Love', @album_id_5),
    ('Moonage Daydream', @album_id_5),
    ('Starman', @album_id_5),
    ('It Ain\'t Easy', @album_id_5),
    ('Lady Stardust', @album_id_5),
    ('Star', @album_id_5),
    ('Hang on to Yourself', @album_id_5),
    ('Ziggy Stardust', @album_id_5),
    ('Suffragette City', @album_id_5),
    ('Rock \'n\' Roll Suicide', @album_id_5);

-- Album 2: Heroes
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Heroes', 2, '1977', 10, 'Album by David Bowie');

-- Get the auto-generated album_id for the inserted album
SET @album_id_6 = LAST_INSERT_ID();

-- Insert statements for tracks on "Heroes" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Beauty and the Beast', @album_id_6),
    ('Joe the Lion', @album_id_6),
    ('"Heroes"', @album_id_6),
    ('Sons of the Silent Age', @album_id_6),
    ('Blackout', @album_id_6),
    ('V-2 Schneider', @album_id_6),
    ('Sense of Doubt', @album_id_6),
    ('Moss Garden', @album_id_6),
    ('Neuköln', @album_id_6),
    ('The Secret Life of Arabia', @album_id_6);

-- Insert statements for Adele's albums
-- Album 1: 19
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('19', 3, '2008', 12, 'Debut Studio Album by Adele');

-- Get the auto-generated album_id for the inserted album
SET @album_id_7 = LAST_INSERT_ID();

-- Insert statements for tracks on "19" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Hometown Glory', @album_id_7),
    ('I\'ll Be Waiting', @album_id_7),
    ('Don\'t You Remember', @album_id_7),
    ('Turning Tables', @album_id_7),
    ('Set Fire to the Rain', @album_id_7),
    ('If It Hadn\'t Been for Love', @album_id_7),
    ('My Same', @album_id_7),
    ('Take It All', @album_id_7),
    ('Rumour Has It', @album_id_7),
    ('Right as Rain', @album_id_7),
    ('One and Only', @album_id_7),
    ('Lovesong', @album_id_7);

-- Album 2: 21
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('21', 3, '2011', 11, 'Second Studio Album by Adele');

-- Get the auto-generated album_id for the inserted album
SET @album_id_8 = LAST_INSERT_ID();

-- Insert statements for tracks on "21" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Rolling in the Deep', @album_id_8),
    ('Rumour Has It', @album_id_8),
    ('Turning Tables', @album_id_8),
    ('Don\'t You Remember', @album_id_8),
    ('Set Fire to the Rain', @album_id_8),
    ('He Won\'t Go', @album_id_8),
    ('Take It All', @album_id_8),
    ('I\'ll Be Waiting', @album_id_8),
    ('One and Only', @album_id_8),
    ('Lovesong', @album_id_8),
    ('Someone Like You', @album_id_8);

-- Insert statements for Elton John's albums
-- Album 1: Goodbye Yellow Brick Road
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Goodbye Yellow Brick Road', 4, '1973', 17, 'Album by Elton John');

-- Get the auto-generated album_id for the inserted album
SET @album_id_9 = LAST_INSERT_ID();

-- Insert statements for tracks on "Goodbye Yellow Brick Road" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Funeral for a Friend/Love Lies Bleeding', @album_id_9),
    ('Candle in the Wind', @album_id_9),
    ('Bennie and the Jets', @album_id_9),
    ('Goodbye Yellow Brick Road', @album_id_9),
    ('This Song Has No Title', @album_id_9),
    ('Grey Seal', @album_id_9),
    ('Jamaica Jerk-Off', @album_id_9),
    ('I\'ve Seen That Movie Too', @album_id_9),
    ('Sweet Painted Lady', @album_id_9),
    ('The Ballad of Danny Bailey (1909–34)', @album_id_9),
    ('Dirty Little Girl', @album_id_9),
    ('All the Girls Love Alice', @album_id_9),
    ('Your Sister Can\'t Twist (But She Can Rock \'n Roll)', @album_id_9),
    ('Saturday Night\'s Alright for Fighting', @album_id_9),
    ('Roy Rogers', @album_id_9),
    ('Social Disease', @album_id_9),
    ('Harmony', @album_id_9);

-- Album 2: Captain Fantastic and the Brown Dirt Cowboy
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Captain Fantastic and the Brown Dirt Cowboy', 4, '1975', 10, 'Album by Elton John');

-- Get the auto-generated album_id for the inserted album
SET @album_id_10 = LAST_INSERT_ID();

-- Insert statements for tracks on "Captain Fantastic and the Brown Dirt Cowboy" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Captain Fantastic and the Brown Dirt Cowboy', @album_id_10),
    ('Tower of Babel', @album_id_10),
    ('Bitter Fingers', @album_id_10),
    ('Tell Me When the Whistle Blows', @album_id_10),
    ('Someone Saved My Life Tonight', @album_id_10),
    ('(Gotta Get a) Meal Ticket', @album_id_10),
    ('Better Off Dead', @album_id_10),
    ('Writing', @album_id_10),
    ('We All Fall in Love Sometimes', @album_id_10),
    ('Curtains', @album_id_10);

-- Insert statements for Bob Marley's albums
-- Album 1: Legend
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Legend', 5, '1984', 14, 'Compilation Album by Bob Marley & The Wailers');

-- Get the auto-generated album_id for the inserted album
SET @album_id_11 = LAST_INSERT_ID();

-- Insert statements for tracks on "Legend" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Is This Love', @album_id_11),
    ('No Woman, No Cry (Live)', @album_id_11),
    ('Could You Be Loved', @album_id_11),
    ('Three Little Birds', @album_id_11),
    ('Buffalo Soldier', @album_id_11),
    ('Get Up, Stand Up', @album_id_11),
    ('Stir It Up', @album_id_11),
    ('One Love/People Get Ready', @album_id_11),
    ('I Shot the Sheriff', @album_id_11),
    ('Waiting in Vain', @album_id_11),
    ('Redemption Song', @album_id_11),
    ('Satisfy My Soul', @album_id_11),
    ('Exodus', @album_id_11),
    ('Jamming', @album_id_11);

-- Album 2: Natty Dread
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Natty Dread', 5, '1974', 9, 'Album by Bob Marley & The Wailers');

-- Get the auto-generated album_id for the inserted album
SET @album_id_12 = LAST_INSERT_ID();

-- Insert statements for tracks on "Natty Dread" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Lively Up Yourself', @album_id_12),
    ('No Woman, No Cry', @album_id_12),
    ('Them Belly Full (But We Hungry)', @album_id_12),
    ('Rebel Music (3 O\'Clock Roadblock)', @album_id_12),
    ('So Jah Seh', @album_id_12),
    ('Natty Dread', @album_id_12),
    ('Bend Down Low', @album_id_12),
    ('Talkin\' Blues', @album_id_12),
    ('Revolution', @album_id_12);

-- Insert statements for Madonna's albums
-- Album 1: Like a Virgin
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Like a Virgin', 6, '1984', 9, 'Album by Madonna');

-- Get the auto-generated album_id for the inserted album
SET @album_id_13 = LAST_INSERT_ID();

-- Insert statements for tracks on "Like a Virgin" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Material Girl', @album_id_13),
    ('Angel', @album_id_13),
    ('Like a Virgin', @album_id_13),
    ('Over and Over', @album_id_13),
    ('Love Don\'t Live Here Anymore', @album_id_13),
    ('Dress You Up', @album_id_13),
    ('Shoo-Bee-Doo', @album_id_13),
    ('Pretender', @album_id_13),
    ('Stay', @album_id_13);

-- Album 2: True Blue
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('True Blue', 6, '1986', 9, 'Album by Madonna');

-- Get the auto-generated album_id for the inserted album
SET @album_id_14 = LAST_INSERT_ID();

-- Insert statements for tracks on "True Blue" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Papa Don\'t Preach', @album_id_14),
    ('Open Your Heart', @album_id_14),
    ('White Heat', @album_id_14),
    ('Live to Tell', @album_id_14),
    ('Where\'s the Party', @album_id_14),
    ('True Blue', @album_id_14),
    ('La Isla Bonita', @album_id_14),
    ('Jimmy Jimmy', @album_id_14),
    ('Love Makes the World Go Round', @album_id_14);


-- Insert statement for "Curtain Call" album by Eminem
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Curtain Call', 7, '2005', 16, 'Greatest Hits Compilation Album by Eminem');

-- Get the auto-generated album_id for the inserted album
SET @album_id_1 = LAST_INSERT_ID();

-- Insert statements for tracks on "Curtain Call" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Intro', @album_id_1),
    ('Fack', @album_id_1),
    ('The Way I Am', @album_id_1),
    ('My Name Is', @album_id_1),
    ('Stan', @album_id_1),
    ('Lose Yourself', @album_id_1),
    ('Shake That', @album_id_1),
    ('Sing for the Moment', @album_id_1),
    ('Without Me', @album_id_1),
    ('Like Toy Soldiers', @album_id_1),
    ('The Real Slim Shady', @album_id_1),
    ('Mockingbird', @album_id_1),
    ('Guilty Conscience', @album_id_1),
    ('Cleanin\' Out My Closet', @album_id_1),
    ('Just Lose It', @album_id_1),
    ('When I\'m Gone', @album_id_1);

-- Insert statement for "Relapse" album by Eminem
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Relapse', 7, '2009', 20, 'Album by Eminem');

-- Get the auto-generated album_id for the inserted album
SET @album_id_2 = LAST_INSERT_ID();

-- Insert statements for tracks on "Relapse" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Dr. West (Skit)', @album_id_2),
    ('3 a.m.', @album_id_2),
    ('My Mom', @album_id_2),
    ('Insane', @album_id_2),
    ('Bagpipes from Baghdad', @album_id_2),
    ('Hello', @album_id_2),
    ('Tonya (Skit)', @album_id_2),
    ('Same Song & Dance', @album_id_2),
    ('We Made You', @album_id_2),
    ('Medicine Ball', @album_id_2),
    ('Paul (Skit)', @album_id_2),
    ('Stay Wide Awake', @album_id_2),
    ('Old Time\'s Sake', @album_id_2),
    ('Must Be the Ganja', @album_id_2),
    ('Mr. Mathers (Skit)', @album_id_2),
    ('Deja Vu', @album_id_2),
    ('Beautiful', @album_id_2),
    ('Crack a Bottle', @album_id_2),
    ('Steve Berman (Skit)', @album_id_2),
    ('Underground', @album_id_2);



-- Insert statements for Taylor Swift's albums
-- Album 1: Fearless
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Fearless', 8, '2008', 13, 'Album by Taylor Swift');

-- Get the auto-generated album_id for the inserted album
SET @album_id_15 = LAST_INSERT_ID();

-- Insert statements for tracks on "Fearless" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Fearless', @album_id_15),
    ('Fifteen', @album_id_15),
    ('Love Story', @album_id_15),
    ('Hey Stephen', @album_id_15),
    ('White Horse', @album_id_15),
    ('You Belong with Me', @album_id_15),
    ('Breathe', @album_id_15),
    ('Change', @album_id_15),
    ('Our Song', @album_id_15),
    ('Teardrops on My Guitar', @album_id_15),
    ('Should\'ve Said No', @album_id_15),
    ('The Way I Loved You', @album_id_15),
    ('Forever & Always', @album_id_15);

-- Album 2: Speak Now
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Speak Now', 8, '2010', 14, 'Album by Taylor Swift');

-- Get the auto-generated album_id for the inserted album
SET @album_id_16 = LAST_INSERT_ID();

-- Insert statements for tracks on "Speak Now" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Mine', @album_id_16),
    ('Sparks Fly', @album_id_16),
    ('Back to December', @album_id_16),
    ('Speak Now', @album_id_16),
    ('Dear John', @album_id_16),
    ('Mean', @album_id_16),
    ('The Story of Us', @album_id_16),
    ('Never Grow Up', @album_id_16),
    ('Enchanted', @album_id_16),
    ('Better Than Revenge', @album_id_16),
    ('Innocent', @album_id_16),
    ('Haunted', @album_id_16),
    ('Last Kiss', @album_id_16),
    ('Long Live', @album_id_16);

-- Insert statements for Michael Jackson's albums
-- Album 1: Thriller
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Thriller', 9, '1982', 9, 'Album by Michael Jackson');

-- Get the auto-generated album_id for the inserted album
SET @album_id_17 = LAST_INSERT_ID();

-- Insert statements for tracks on "Thriller" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Wanna Be Startin\' Somethin\'', @album_id_17),
    ('Baby Be Mine', @album_id_17),
    ('The Girl Is Mine', @album_id_17),
    ('Thriller', @album_id_17),
    ('Beat It', @album_id_17),
    ('Billie Jean', @album_id_17),
    ('Human Nature', @album_id_17),
    ('P.Y.T. (Pretty Young Thing)', @album_id_17),
    ('The Lady in My Life', @album_id_17);

-- Album 2: Bad
INSERT INTO Albums (album_name, artist_id, release_year, num_songs, description)
VALUES ('Bad', 9, '1987', 10, 'Album by Michael Jackson');

-- Get the auto-generated album_id for the inserted album
SET @album_id_18 = LAST_INSERT_ID();

-- Insert statements for tracks on "Bad" album
INSERT INTO Tracks (track_name, album_id)
VALUES
    ('Bad', @album_id_18),
    ('The Way You Make Me Feel', @album_id_18),
    ('Speed Demon', @album_id_18),
    ('Liberian Girl', @album_id_18),
    ('Just Good Friends', @album_id_18),
    ('Another Part of Me', @album_id_18),
    ('Man in the Mirror', @album_id_18),
    ('I Just Can\'t Stop Loving You', @album_id_18),
    ('Dirty Diana', @album_id_18),
    ('Smooth Criminal', @album_id_18);


-- Insert statements for track_artist table
-- Track-Artist Relationships for John Lennon's Albums
-- Track-Artist Relationships
-- Artist 1: John Lennon (Tracks 1-24)
INSERT INTO Track_Artist (track_id, artist_id)
VALUES
    (1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1),
    (11, 1), (12, 1), (13, 1), (14, 1), (15, 1), (16, 1), (17, 1), (18, 1), (19, 1),
    (20, 1), (21, 1), (22, 1), (23, 1), (24, 1);

-- Artist 2: David Bowie (Tracks 25-45)
INSERT INTO Track_Artist (track_id, artist_id)
VALUES
    (25, 2), (26, 2), (27, 2), (28, 2), (29, 2), (30, 2), (31, 2), (32, 2), (33, 2),
    (34, 2), (35, 2), (36, 2), (37, 2), (38, 2), (39, 2), (40, 2), (41, 2), (42, 2),
    (43, 2), (44, 2), (45, 2);

-- Artist 3: Adele (Tracks 46-68)
INSERT INTO Track_Artist (track_id, artist_id)
VALUES
    (46, 3), (47, 3), (48, 3), (49, 3), (50, 3), (51, 3), (52, 3), (53, 3), (54, 3),
    (55, 3), (56, 3), (57, 3), (58, 3), (59, 3), (60, 3), (61, 3), (62, 3), (63, 3),
    (64, 3), (65, 3), (66, 3), (67, 3), (68, 3);

-- Artist 4: Elton John (Tracks 69-95)
INSERT INTO Track_Artist (track_id, artist_id)
VALUES
    (69, 4), (70, 4), (71, 4), (72, 4), (73, 4), (74, 4), (75, 4), (76, 4), (77, 4),
    (78, 4), (79, 4), (80, 4), (81, 4), (82, 4), (83, 4), (84, 4), (85, 4), (86, 4),
    (87, 4), (88, 4), (89, 4), (90, 4), (91, 4), (92, 4), (93, 4), (94, 4), (95, 4);

-- Artist 5: Bob Marley (Tracks 96-118)
INSERT INTO Track_Artist (track_id, artist_id)
VALUES
    (96, 5), (97, 5), (98, 5), (99, 5), (100, 5), (101, 5), (102, 5), (103, 5), (104, 5),
    (105, 5), (106, 5), (107, 5), (108, 5), (109, 5), (110, 5), (111, 5), (112, 5), (113, 5),
    (114, 5), (115, 5), (116, 5), (117, 5), (118, 5);

-- Artist 6: Madonna (Tracks 119-136)
INSERT INTO Track_Artist (track_id, artist_id)
VALUES
    (119, 6), (120, 6), (121, 6), (122, 6), (123, 6), (124, 6), (125, 6), (126, 6), (127, 6),
    (128, 6), (129, 6), (130, 6), (131, 6), (132, 6), (133, 6), (134, 6), (135, 6), (136, 6);

-- Artist 7: Eminem (Tracks 137-172)
INSERT INTO Track_Artist (track_id, artist_id)
VALUES
    (137, 7), (138, 7), (139, 7), (140, 7), (141, 7), (142, 7), (143, 7), (144, 7), (145, 7),
    (146, 7), (147, 7), (148, 7), (149, 7), (150, 7), (151, 7), (152, 7), (153, 7), (154, 7),
    (155, 7), (156, 7), (157, 7), (158, 7), (159, 7), (160, 7), (161, 7), (162, 7), (163, 7),
    (164, 7), (165, 7), (166, 7), (167, 7), (168, 7), (169, 7), (170, 7), (171, 7), (172, 7);

-- Artist 8: Prince (Tracks 173-199)
INSERT INTO Track_Artist (track_id, artist_id)
VALUES
    (173, 8), (174, 8), (175, 8), (176, 8), (177, 8), (178, 8), (179, 8), (180, 8), (181, 8),
    (182, 8), (183, 8), (184, 8), (185, 8), (186, 8), (187, 8), (188, 8), (189, 8), (190, 8),
    (191, 8), (192, 8), (193, 8), (194, 8), (195, 8), (196, 8), (197, 8), (198, 8), (199, 8);

-- Artist 9: Beyoncé (Tracks 200-218)
INSERT INTO Track_Artist (track_id, artist_id)
VALUES
    (200, 9), (201, 9), (202, 9), (203, 9), (204, 9), (205, 9), (206, 9), (207, 9), (208, 9),
    (209, 9), (210, 9), (211, 9), (212, 9), (213, 9), (214, 9), (215, 9), (216, 9), (217, 9), (218, 9);
