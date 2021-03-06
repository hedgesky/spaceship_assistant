## Spaceship assistant

Космические полеты - дело сложное. Чтобы облегчить капитанам их бренные будни и увеличить количество времени, которое они могут проводить за сидением "В межгалактическом контакте", руководством нашей компании "Spaceship Industries" было принято решение о создании системы поддержки.

## Возможности

Пока что данная система находится в зачаточном состоянии, но у нас гора планов. Еще чуть-чуть, и мы сможем преодолевать тысячи световых лет буквально парой команд!

## Использование

Для демонстрации возможностей ассистента достаточно следующий команд:

```
  bundle
  ruby journey.rb
```

## Устройство корабля

Корабль состоит из независимых друг от друга компонентов. На данный момент реализованы двигатель и навигатор. Также к кораблю можно подключать AI, который будет взаимодействовать с другими пилотами.


Почти все действия корабль будет делегировать конкретным своим компонентам. Это позволяет избежать мешанины кода, делая логику различных действий изолированной друг от друга.

## Исключительные ситуации

При попытке сделать что-то невозможное (полететь со скоростью выше максимальной, например) компонент выбрасывает соответствующее исключение. Классы всех исключений определены в файле spaceship/exceptions.rb. Система-ассистент может перехватывать эти исключения, чтобы выводить сообщения об ошибках.

## Статус корабля

Пока что на запрос статуса все один компонент бодро реагируют сообщением о том, что всё в порядке. В дальнейшем, при создании боевой системы, к примеру, могут возникать поломки. А еще можно сделать предупреждения о том, что топлива/боеприпасов мало, или что степент износа близка к поломке, если мы вдруг захотим это сделать... Много чего можно.