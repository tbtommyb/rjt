{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Testimonials.Testimonials where

import Text.Hamlet

data Testimonial = Testimonial { tName :: String
                               , tImgSrc :: Maybe String
                               , tParas :: [String]
                               } deriving (Show)

testimonials :: [Testimonial]
testimonials = [
  Testimonial {
      tName="Fonz",
      tImgSrc=Just "testimonials/fonz-small.jpg",
      tParas=[
        "\"After just 11 sessions I saw a massive difference in my body but more importantly my fitness.",
        "I wanted to up my acceleration and core strength for rugby and Roland tailor-made a plan for me and also devised a food plan.",
        "He taught me loads of new exercises I didn't know about as well as ones I could do at home. He's a genuinely fantastic motivator who helped me push myself to the next level.",
        "Suffice to say I would recommend him to anyone looking for a very personalised and personable PT!\""
      ]
    },
  Testimonial {
      tName="Louise-Anne",
      tImgSrc=Just "testimonials/louise-anne_small.jpg",
      tParas=[
        "\"My fitness life began seven months ago and I've been amazed by the changes since then. Signing up for sessions with Roland was literally the best decision I made for myself in 2017.",
        "He really knows his stuff and has taught me about lots of positive changes - diet and so on - and how to apply them to my daily life.",
        "Working with Roland has improved my confidence and given me a real boost, both inside the gym and outside. I love how the varied workouts keep me on my toes (literally!) and my strength has increased rapidly.",
        "Our sessions are always interactive and he pushes me to perform at my best. Even when working out alone I've been able to dig into that motivation and drive myself to do my best.\""
      ]
    },
  Testimonial {
      tName="Leah",
      tImgSrc=Just "testimonials/leah-small.jpg",
      tParas=[
         "A massive congratulations to Leah for her 2 year fat loss journey.",
      "With hard work we managed to break her plateau of being a \"cardio bunny\" to a weight training and HIIT machine!",
      "To anyone that thinks squats, deadlifts and overhead presses will make a woman bulky, I hope these pictures will help bury that myth! - Roland"
             ]
      },
    Testimonial {
      tName="Georgia",
      tImgSrc=Just "testimonials/georgia-small.jpg",
      tParas=[
      "\"Roland is a top quality personal trainer!",
      "I am into my fourth month of being trained by Roland and I am very happy with the results so far.",
      "I would highly recommend Roland if you are serious about transforming your body.\""
      ]
      },
    Testimonial {
      tName="Bianca",
      tImgSrc=Nothing,
      tParas=[
                "\"I've been training with Roland for over five months now. I'm the happiest and fittest I've ever been in my entire life! Before I was lazy, overweight and crazy about cardio and counting calories. Going to the gym at the end of a long day at work felt like a massive pain. I never saw any results good enough to make me think I could actually change my jiggly body.",
      "Now, thanks to Roland, I can't wait to train, I can't wait to push myself and I can't wait to hit new personal tests. I see my little muscles growing session after session and my strength and my mood have never been so good.",
      "Every session with him is full of big laughs, fun and PUSH PUSH PUSH! I finally love working out! He's made a big change in my life and is a great personal trainer and friend. Thanks thanks thanks!\""
             ]
      },
    Testimonial {
      tName="Simon",
      tImgSrc=Nothing,
      tParas=[
                "\"I started training with Roland in April 2016. I'm in my mid thirties and was far from the best shape of my life.",
      "Since training with him I have seen significant and consistent improvements in my strength, fitness and physique. I haven't had a single session where I haven't felt like I've worked hard and achieved something. Not only does he keep me motivated and focused but he explains what we're doing and why, so it's easy to see the value in everything.",
      "Throughout the training I've also gained a far better understanding of my diet and how to adjust it to see the best results. On top of all this he's a really good guy. If you want a fun, professional and hard working PT, and real results, I can't recommend Roland enough.\""
             ]
      },
    Testimonial {
      tName="Julie",
      tImgSrc=Nothing,
      tParas=[
                "\"I started training with Roland over 6 months ago. At first I was quite skeptical about having a personal trainer but I have completely changed my mind!",
      "Roland pushes me in a way that I would never be able to do  myself. I have seen real changes in my body over the past few months, I am fitter and I genuinely feel healthier and happier with my body.",
      "Finally, Roland has managed to make going to the gym a happy time in my week. It's no longer a chore to work out! Thank you for everything!\""
             ]
      }
  ]

partial :: Html
partial = $(shamletFile "src/Views/Pages/Testimonials/testimonials.hamlet")
