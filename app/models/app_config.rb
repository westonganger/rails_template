module AppConfig
  
  LOREM_IPSUM = <<~HEREDOC
  Vel quia voluptatem voluptas autem. Velit vel dolore ullam id qui. Et et ipsum voluptatem animi modi ea dolore. Adipisci autem id consectetur a labore illo dicta. Blanditiis consequatur sit dolor.

  Aliquid sit quas aliquid quae omnis et perferendis consequatur. Beatae qui dignissimos sed error ut provident aut. Omnis molestiae sint voluptatem.
  HEREDOC

  BOOTSWATCH_OPTIONS = [
    'Cerulean',
    'Cosmo',
    'Cyborg',
    'Darkly',
    'Flatly',
    'Journal',
    'Litera',
    'Lumen',
    'Lux',
    'Materia',
    'Minty',
    'Pulse',
    'Sandstone',
    'Simplex',
    'Sketchy',
    'Slate',
    'Solar',
    'Spacelab',
    'Superhero',
    'United',
    'Yeti',
  ].map{|x| [x, x.downcase]}.freeze

end
