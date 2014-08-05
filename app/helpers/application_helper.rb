module ApplicationHelper
  QUOTES = [
    ["If it ain't broke, don't fix it."],
    ["Know your enemy and know yourself and you can fight a hundred battles without disaster.", "Sun Tzu"],
    ["I always tried to turn every disaster into an opportunity.", "John D. Rockefeller"],
    ["You can't live someone else's expectations in life. It's a recipe for disaster.", "Bear Grylls"],
    ["Some people don't like change, but you need to embrace change if the alternative is disaster.", "Elon Musk"],
    ["Even when you take a holiday from technology, technology doesn't take a break from you.", "Douglas Coupland"],
    ["Man is still the most extraordinary computer of all.", "John F. Kennedy"],
    ["A computer once beat me at chess, but it was no match for me at kick boxing.", "Emo Philips"],
    ["Never trust a computer you can't throw out a window.", "Steve Wozniak"],
    ["Computers are useless. They can only give you answers.", "Pablo Picasso"],
    ["Treat your password like your toothbrush. Don't let anybody else use it, and get a new one every six months.", "Clifford Stoll"],
    ["Imagine if every Thursday your shoes exploded if you tied them the usual way. This happens to us all the time with computers, and nobody thinks of complaining.", "Jef Raskin"],
    ["Computers are like Old Testament gods; lots of rules and no mercy.", "Joseph Campbell"]
  ]
  def random_quote
    quote = QUOTES.sample
    "'#{ quote[0] }' - #{ quote[1] || 'Anon' }"
  end
end
