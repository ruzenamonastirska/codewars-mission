fn snail(matrix: &[Vec<i32>]) -> Vec<i32> {
    let row_count = matrix.len();
    if row_count == 0 { return vec![] }

    let col_count = matrix[0].len();
    if col_count == 0 { return vec![] }

    let mut min_row = 0;
    let mut max_row = row_count - 1;
    let mut min_col = 0;
    let mut max_col = col_count - 1;

    let mut result: Vec<i32> = Vec::with_capacity(row_count * col_count);
    let mut row = 0;
    let mut col = 0;

    loop {
        // Right
        if min_col > max_col { break }
        while col < max_col {
            result.push(matrix[row][col]);
            col += 1;
        }
        min_row += 1;

        // Down
        if min_row > max_row { break }
        while row < max_row {
            result.push(matrix[row][col]);
            row += 1;
        }
        max_col -= 1;

        // Left
        if min_col > max_col { break }
        while col > min_col {
            result.push(matrix[row][col]);
            col -= 1;
        }
        max_row -= 1;

        // Up
        if min_row > max_row { break }
        while row > min_row {
            result.push(matrix[row][col]);
            row -= 1;
        }
        min_col += 1;
    }

    // Last piece remaining in bounds
    result.push(matrix[row][col]);

    result
}
