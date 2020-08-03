function calculation(){
	const priceId = document.getElementById("item_price");

	priceId.addEventListener("input", function(e){
		const taxPrice = document.getElementById("add-tax-price");
		const salesProfit = document.getElementById("profit");

		if (this.value.match(/[0-9]/)){
			let tax_value = Math.round(this.value * 0.1)
			let profit_value = Math.round(this.value * 0.9)
			taxPrice.innerHTML = tax_value
			salesProfit.innerHTML = profit_value
		}else{
			taxPrice.innerHTML = "半角数字のみ入力可能"
			salesProfit.innerHTML = "半角数字のみ入力可能"
		};
		e.preventDefault();
	});

}

setInterval(calculation, 1000);