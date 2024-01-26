struct BalancedPairs {
    n: u16,
    buffer: Vec<char>,
    result: Vec<String>
}

impl BalancedPairs {
    fn generate(&mut self, pos: usize, balance: u16, remaining_open: u16) {
        if 0 == remaining_open && 0 == balance {
            self.result.push(self.buffer.iter().collect())
        } else {
            if remaining_open > 0 {
                self.buffer[pos] = '(';
                self.generate(pos + 1, balance + 1, remaining_open - 1);
            }
            if balance > 0 {
                self.buffer[pos] = ')';
                self.generate(pos + 1, balance - 1, remaining_open);
            }
        }
    }
}

fn balanced_parens(n: u16) -> Vec<String> {
    let mut pairs = BalancedPairs {
        n,
        buffer: vec![' '; (n * 2) as usize],
        result: vec![]
    };
    pairs.generate(0, 0, n);
    pairs.result
}
