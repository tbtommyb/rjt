{-# LANGUAGE TemplateHaskell #-}

module Views.Pages.Home.About where

import Text.Hamlet

import Types

title :: String
title = "About me"

image :: String
image = "/img/about.jpg"

paragraphs :: [String]
paragraphs = [
      "Do you want to be leaner? Fitter? Stronger? I'm here to help you achieve your goals.",
      "As your personal trainer, I'll guide you through a series of positive changes and make sure they stay with you for the long-term. When you train with me you'll push boundaries you didn't even know you had.",
      "With my structured plans, every session is fun and goal-orientated, leaving you knowing you've worked hard — and smart.",
      "Get a taster of my training and fitness advice on [my blog](https://medium.com/@rolandjohnson_75946). I offer one-to-one personal training and fitness advice in Liverpool Street, East London and personalised online training and diet packages to clients around the world.",
      "Check out what my clients say and get in touch with me for a free consultation to start your journey."
      ]

videoParagraphs :: [String]
videoParagraphs = [
        "I became a personal trainer because a great coach helped me overcome difficulties and achieve my goals. Watch this video to see my story and what I can do for you:"
                  ]

slug :: String
slug = "rOzmNGRi1rg"

partial :: Html
partial = $(shamletFile "src/Views/Pages/Home/about.hamlet")
