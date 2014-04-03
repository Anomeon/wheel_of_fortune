#variables
map = {
  'великие личности' => %w[
    гитлер
    сталин
    хрущев
    якубович
    сахаров
    жуков
    буш
  ],
  'марки телефонов' => %w[
    эпл
    сименс
    нокия
    моторолла
    самсунг
    алкатель
  ],
}

array_for_categories = []
map.each_key { |b| array_for_categories.push b }
rand_for_key_i = rand(array_for_categories.length)
$key_s = array_for_categories[rand_for_key_i]
rand_for_value_i = rand(map[$key_s].length)
word = map[$key_s][rand_for_value_i]
immutable_word = map[$key_s][rand_for_value_i]
length = word.length
$crypt = "\*" * length
charsleft = word
points = [0, 100, 200, 300]
$persons = [['', 0], ['Анатолий Вассерман', 0], ['Александр Друзь', 0],]
person = 0
counter = 0
$alphabet = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
$alphabet_for_ai = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
$modified_alphabet = $alphabet.split('').join(' ')
print 'Введите ваше имя: '
$persons[0][0] = gets.chomp

def balance
  for i in 0..2
    puts "#{$persons[i][0]}: #{$persons[i][1]}"
  end
end


def reload_alphabet
  for i in 0..32
    $alphabet[i] = "\*" if $alphabet[i] == $input
  end
  unless $input.nil?
    $alphabet_for_ai.delete!($input)
    $modified_alphabet = $alphabet.split('').join(' ')
  end
end


def ai
  $rand_char = $alphabet_for_ai.length
  $alphabet_for_ai[rand($rand_char)]
end


def standartscreen(x, y)
  sleep x
  system 'clear' if y == 0
  puts "Рубрика: #{$key_s}"
  puts "\n#{$modified_alphabet}"
  balance
  puts "\n Слово: #{$crypt}"
end


while true
  result = rand(13)
  standartscreen(0, 0)

  puts "\n#{$persons[person][0]} вращайте барабан!"
  gets
  case result
    when 1..4
      point = 1
    when 5..8
      point = 2
    when 9..12
      point = 3
    when 0
      point = 0
    end
  $persons[person][1] += points[point]
  
  standartscreen(0, 0)
  puts "\n#{points[point]} очков! Назовите букву или слово целиком!"

  if $persons[0] == $persons[person]
    $input = gets.chomp
  else
    $input = ai
    reload_alphabet
    puts "#{$persons[person][0]}: \"Я думаю что это буква '#{$input}'\""
    gets
  end
  
  unless $input.length > 1
    havechanges = []
    
    for i in 0...length
      if charsleft[i] == $input
        havechanges[i] = $input
        $crypt[i] = $input
        charsleft[i] = "\*"
        reload_alphabet
      end
    end
    if havechanges == []
      reload_alphabet
      standartscreen(0, 0)
      puts "\nНет такой буквы! Ход переходит к следующему игроку"
      gets
      counter += 1
      person = counter % 3
    else
      standartscreen(0, 0)
      puts "\nЕсть такая буква! Откройте букву '#{$input}'"
      gets
    end
  else
    if $input == immutable_word
      standartscreen(0, 0)
      puts "\nПравильно! Это слово: #{immutable_word}. Поздравляем!"
      gets
    else
      standartscreen(0, 0)
      puts "\nК сожалению это не то слово. Правильное: #{immutable_word}"
      gets
    end
    exit

  end
  if charsleft == "\*" * length
    puts "#{$persons[person][0]} поздравляем с победой!!!"
    break
  end
end