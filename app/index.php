<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Commerce Warehouse</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <main>
        <header>
            <p class="eyebrow">ECOMMERCE WAREHOUSE</p>
            <h1>Revenue, orders, and delivery intelligence.</h1>
            <p class="lede">Explore the star schema through filtered analytical reports.</p>
        </header>
        <section class="controls">
            <label>Report<select id="report"><option value="monthly">Monthly roll-up</option><option value="products">Product drill-down</option><option value="countries">Country dice</option><option value="delivery">Delivery pivot</option></select></label>
            <label>From<input id="start" type="date" value="2025-01-01"></label>
            <label>To<input id="end" type="date" value="2025-12-31"></label>
            <label>Category<input id="category" placeholder="Optional"></label>
            <button id="run">Run report</button>
        </section>
        <p id="status" class="status"></p>
        <section class="table-wrap"><table><thead id="head"></thead><tbody id="body"></tbody></table></section>
    </main>
    <script>
        const report = document.querySelector('#report');
        const status = document.querySelector('#status');
        const head = document.querySelector('#head');
        const body = document.querySelector('#body');
        const money = value => Number(value).toLocaleString(undefined, { style: 'currency', currency: 'PHP' });
        async function load() {
            status.textContent = 'Loading';
            const params = new URLSearchParams({ report: report.value, start: document.querySelector('#start').value, end: document.querySelector('#end').value, category: document.querySelector('#category').value });
            const response = await fetch(`api.php?${params}`);
            const result = await response.json();
            if (!response.ok) { status.textContent = result.error; return; }
            const rows = result.rows;
            const columns = rows.length ? Object.keys(rows[0]) : [];
            head.innerHTML = `<tr>${columns.map(column => `<th>${column.replaceAll('_', ' ')}</th>`).join('')}</tr>`;
            body.innerHTML = rows.map(row => `<tr>${columns.map(column => `<td>${column.includes('revenue') ? money(row[column]) : (row[column] ?? 'Unknown')}</td>`).join('')}</tr>`).join('');
            status.textContent = `${rows.length} rows`;
        }
        document.querySelector('#run').addEventListener('click', load);
        load();
    </script>
</body>
</html>
