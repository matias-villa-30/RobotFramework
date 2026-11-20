from robot.api.deco import keyword, library
from datetime import datetime
import random
import string

@library
class RandomLibrary:
    """Library for creating random cars for Lab 8"""
    car_models = {
        "Toyota": ["Corolla", "Camry", "RAV4", "Yaris"],
        "BMW": ["3 Series", "5 Series", "X3", "X5"],
        "Ford": ["Focus", "Fiesta", "Mustang", "Explorer"],
        "Audi": ["A3", "A4", "A6", "Q5"],
        "Mercedes-Benz": ["C-Class", "E-Class", "S-Class", "GLC"],
        "Volkswagen": ["Golf", "Passat", "Polo", "Tiguan"],
        "Honda": ["Civic", "Accord", "CR-V", "Jazz"],
        "Hyundai": ["i30", "Elantra", "Tucson", "Santa Fe"],
        "Kia": ["Ceed", "Sportage", "Rio", "Sorento"],
        "Nissan": ["Micra", "Qashqai", "X-Trail", "Altima"],
        "Skoda": ["Octavia", "Fabia", "Superb", "Kodiaq"]
    }
    car_test2 = {
        "Toyota": ["Corolla", "Camry", "RAV4", "Yaris"],
        "Audi": ["A3", "A4", "A6", "Q5"],
        "Skoda": ["Octavia", "Fabia", "Superb", "Kodiaq"]
    }

    @keyword
    def generate_car_brand(self):
        brand = random.choice(list(self.car_models.keys()))
        return brand

    @keyword
    def generate_car_model(self):
        brand = random.choice(list(self.car_models.keys()))
        model = random.choice(self.car_models[brand])
        return model

    @keyword
    def generate_mileage(self):
        return random.randint(0, 300_000)

    @keyword
    def generate_year(self):
        current_year = datetime.now().year
        return random.randint(1995, current_year)

    @keyword
    def generate_plate(self):
        letters = ''.join(random.choices(string.ascii_uppercase, k=3))
        numbers = ''.join(random.choices(string.digits, k=3))
        return f"{letters}-{numbers}"

    @keyword
    def generate_test2_brand(self):
        brand = random.choice(list(self.car_test2.keys()))
        return brand

    @keyword
    def generate_test2_model(self):
        brand = random.choice(list(self.car_test2.keys()))
        model = random.choice(self.car_test2[brand])
        return model
