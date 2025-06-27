from collections import Counter

class StatisticsCalculator:
    def __init__(self, numbers):
        self.numbers = numbers

    def mean(self):
        return sum(self.numbers) / len(self.numbers)

    def median(self):
        sorted_nums = sorted(self.numbers)
        n = len(sorted_nums)
        mid = n // 2
        if n % 2 == 0:
            return (sorted_nums[mid - 1] + sorted_nums[mid]) / 2
        else:
            return sorted_nums[mid]

    def mode(self):
        count = Counter(self.numbers)
        max_freq = max(count.values())
        return [num for num, freq in count.items() if freq == max_freq]

# Example usage:
data = [4, 2, 2, 8, 3, 3, 3]
calc = StatisticsCalculator(data)

print("Mean:", calc.mean())
print("Median:", calc.median())
print("Mode(s):", calc.mode())
