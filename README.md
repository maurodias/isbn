# Isbn Number

The Isbn oject can calculate its check digit and return it as valid ISBN number

## How calculation works

1. Take each digit, from left to right and multiply them alternatively by 1 and 3
2. Sum those numbers
3. Take mod 10 of the summed figure
4. Subtract 10 and if the end number is 10, make it 0
Example for 978014300723: we should get 9780143007234


## Usage

- It accepts 12 digits and calculate a the check digit and append it to the end returning the valid ISBN13 number
e.g.
```rb
Isbn::Number.new(number: 978014300723).validate_number!
=> "9780143007234"
```

- It accepts 13 digits and validate whether it is a correct ISBN number. If it is not valid it will return the valid ISBN number.
```rb
Isbn::Number.new(number: 9780143007231).validate_number!
=> "9780143007234"
```
or
```rb
Isbn::Number.new(number: 9780143007234).validate_number!
=> "9780143007234"
```

## Running

Run `docker-compose pull`
Run `docker-compose build`
Run `docker-compose run --rm app bundle install`
Run `docker-compose up` to run its tests
