-- DELETE FROM users;
-- DELETE FROM tweet;
--
-- DROP SEQUENCE IF EXISTS comments_id_seq;
-- DROP SEQUENCE IF EXISTS followers_id_seq;
-- DROP SEQUENCE IF EXISTS tweet_id_seq;

INSERT INTO users
  (username, password, first_name, last_name, email)
VALUES
  ('DGULCO', 'dgulco', 'Dmitrii', 'Gulco', 'dgulco@endava.com'),
  ('ACUSNIR', 'acusnir', 'Alexandr', 'Cusnir', 'acusnir@endava.com'),
  ('MBEZALIUC', 'mbezaliuc', 'Mila', 'Bezaliuc', 'mbezaliuc@endava.com'),
  ('IUNKA', '123456','Iunona', 'Panasenko','panasenko@gmail.com'),
  ('VCRACIUN', '123456', 'Victor', 'Craciun', 'craciun@gmail.com'),
  ('MAXIM', '123456','Maxim', 'Ustimov','ustimov@gmail.com');

INSERT INTO tweet
  (user_id, text, postDateTime)
VALUES
  (1, 'Hi, people. Nice to see you there!', getdate()),
  (2, 'Awesome weather outside! I ENJOY IT!', getdate()),
  (3, 'Wowwwww 5 years 5 boys what an amazing journey I couldn''t thank you all ever enough and thank you Louis Niall Harry and zayn for everything', getdate()),
  (4, 'applied for xfactor,hope it all wrks out', getdate()),
  (1, 'First thing I saw opening FB today was a meme of a cat praying, with directions to ''like'' to be blessed.

And that''s exactly why I''m here.

', getdate()),
  (5, 'The hardest part of Twitter? Trying to figure out what you''re actually addicted to', getdate()),
  (6, 'Always cultivate grace.', getdate()),
  (5, 'I''m one nap away from completing one full night''s sleep for the year.', getdate()),
  (1, 'Somebody knocked at my door while I was on Twitter. I couldn''t answer it.
They left a note.
It was opportunity.
Whew. That was close.', getdate()),
  (2, 'She wears short skirts
I eat pizza
She''s cheer captain
And I''m still eating pizza', getdate()),
  (5, 'I want the job where you push scared skydivers out of a plane.', getdate()),
  (4, 'No matter how long you have traveled in the wrong direction, you can always change course', getdate()),
  (3, 'WOW! What an epic opening day yesterday, we have literally never seen anything like it...', getdate()),
  (5, 'Volvamos de @DulceMaria ya tiene más de 1.300.000 views. Entren a su canal oficial y véanlo cuántas veces quieran', getdate()),
  (1, 'I wish us all the best of luck in navigating this devastatingly divisive climate.', getdate()),
  (3, 'The Celtics scored 8 points in the 1st quarter - the fewest they''ve scored in the first in over 4 decades.', getdate()),
  (2, 'Es un honor recibir este @Premios_Ondas y quiero dedicárselo a todos aquellos que han hecho posible que mi carrera sea tan importante.', getdate()),
  (4, 'I know some of u come to my page looking for words of encouragement and I''m sorry I failed u this time. All I can say: stay angry, send love', getdate()),
  (2, 'Echando de menos uno de mis deportes favoritos.
Para cuando una inmersión juntos?', getdate()),
  (1, 'So excited to finally announce EPIC 5.0!
This will be the biggest and most advanced EPIC by far!
Pre-sale Signup:
http://creamfields.com/steelyard ', getdate()),
  (6, 'I''ve been hooked on Skyrim SE this week. My PS4 Pro arrives tomorrow...then the real COD grind begins. I wonder if it''ll be much different.', getdate()),
  (2, 'Been sitting here for like 1 hour just thinking where im accually standing as a gamer and as a person i couldn''t be more happy and satisfied', getdate()),
  (1, 'Good morning twitterers. I hope everyone has a marvelous day.', getdate()),
  (5, 'Let me tell you ''bout the story from Huraches to Versaces. My partner pulled up, I had to chef it up, hibachi. I gotta go to work.', getdate()),
  (3, 'If you''re upset it''s probably just best to stay off social media right now. It''s just as easy to be stressed as it is to add to it', getdate()),
  (2, 'INCREIBLE nuestra unión y nuestro amor! Gracias por acompañarm.... http://tmi.me/1fgndF ', getdate()),
  (1, 'Today I become a fashionista! What do you think of my cool new look?', getdate()),
  (6, 'Volatile times. Holding my breath.', getdate()),
  (7, 'Happen to be in NYC election night... The energy in the city is absolutely insane ', getdate());



  insert into comments
  (user_id,tweet_id,text)
  values
  (1,1,'Same feeling!'),
  (2,1,'Do you realy think so?'),
  (3,2,'Good job!'),
  (3,3,'Not that good!'),
  (4,4,'I am with you!'),
  (5,4,'No no no'),
  (6,5,'Pokemons rule'),
  (1,5,'Follow me!'),
  (2,6,'Glad to see ya'),
  (4,6,'Lets go to the Mall'),
  (5,7,'Time to sleep!'),
  (5,7,'Keep it goin!'),
  (6,8,'Time matters'),
  (4,8,'Lazy time'),
  (3,9,'Is it really you'),
  (5,9,'Come on, just do it!'),
  (6,10,'Fallin asleep!'),
  (3,10,'have a nice day , guys!');



