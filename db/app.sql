CREATE TABLE reviews (
  id INTEGER PRIMARY KEY,
  reviewer_name VARCHAR(255) NOT NULL,
	content TEXT NOT NULL,
	rating INTEGER NOT NULL,
  film_id INTEGER NOT NULL,

  FOREIGN KEY(film_id) REFERENCES film(id)
);

CREATE TABLE films (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
	content TEXT NOT NULL,
	imdb_link VARCHAR(255)
);

INSERT INTO
  films (id, name, content, imdb_link)
VALUES
  (1, "The Room", "The quintessential trash film.", "https://www.imdb.com/title/tt0368226/"), 
	(2, "Troll 2", "Classic trash", "https://www.imdb.com/title/tt0105643/?ref_=nv_sr_srsg_0"),
	(3, "Birdemic", "Mind-numbingly awesome!", "https://www.imdb.com/title/tt1316037/?ref_=nv_sr_srsg_0");

INSERT INTO
  reviews (id, reviewer_name, content, rating, film_id)
VALUES
  (1, "Boss", "Ruined my childhood. Saved my adulthood", 1, 1),
  (2, "Johnny", "This film tore me apart!", 1, 1),
  (3, "Chris R", "I went to jail bc of this film. Don't worry, I'll be there for a long time.", 1, 1),
  (4, "Bob", "Best worst movie about vegan trolls", 5, 2),
  (5, "Rando", "Illegal in 12 countries.", 1, 3),
  (6, "Catless", "My grandma hates this film", 5, 3);

