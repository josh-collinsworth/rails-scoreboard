<template>
	<article class="card" v-if="game && player">
		<h2>{{ player.name }}</h2>

		<p class="score">
			<span class="prepend">{{ game.options.prepend }}</span>{{ player.score || 0 }}<span class="append">{{ game.options.append }}</span>
		</p>
		<div class="button-board half">
			<button v-if="showOnes" @click="incrementScore(-1)" :disabled="disableCard">-1</button>
			<button v-if="showOnes" @click="incrementScore(1)" :disabled="disableCard">+1</button>

			<button @click="incrementScore(game.options.increment * -1)" :disabled="disableCard">-{{ game.options.increment }}</button>
			<button @click="incrementScore(game.options.increment)" :disabled="disableCard">+{{ game.options.increment }}</button>

			<button v-if="game.options.add_halve" @click="incrementScore(player.score * -0.5)">÷2</button>
			<button v-if="game.options.add_double" @click="incrementScore(player.score)">×2</button>
		</div>
		<div class="button-board reset" v-if="game.options.add_reset">
			<button @click="incrementScore((player.score * -1), `Are you sure you want to reset ${player.name}'s score to zero?`)">Reset to 0</button>
		</div>
	</article>
</template>


<script>
import axios from 'axios'

export default {
	data: () => ({
		disableCard: false
	}),
	props: {
		player: {
			type: Object,
			required: true
		},
		game: {
			type: Object,
			required: true
		}
	},
	methods: {
		incrementScore(amount, alert) {
			if (alert) {
				const confirmation = confirm(alert)

				if (!confirmation) return
			}

			this.disableCard = true
			let newScore = Number(this.player.score || 0)

			newScore += Number(amount)

			const data = { new_score: newScore }
			axios
				.put(`/api/game_participants/${this.game.id}?player=${this.player.id}`, data)
				.then(response => {
					if(response.data.success) {
						this.$emit('refresh')
					} else {
						console.log("ERRORs")
					}
					this.disableCard = false
				})
		}
	},
	computed: {
		showOnes() {
			return this.game.options.include_increment_by_one && this.game.options.increment != 1
		}
	}
}
</script>


<style scoped lang="scss">
	@import '../../../../assets/stylesheets/vars';

	.card {
		padding: 1rem;
		border-radius: .5rem;
		background: $white;
		text-align: center;
		border: 2px solid $darkGray;

		h2 {
			margin: 0;
		}

		.score {
			text-align: center;
			font-size: 2.5rem;
			font-weight: bold;
			margin: .5em auto;

			.prepend,
			.append {
				font-size: .75em;
				font-weight: normal;
				color: $mediumGray;
				margin: 0 .25rem;
			}
		}

		.button-board {
			display: grid;
			grid-gap: 1rem;

			button {
				margin: 0;
				/* background: $lightBlue; */
				font-size: 1.25rem;
				border-color: $darkGray;

				&:hover {
					box-shadow: none;
					background: $yellow;
				}

				&:focus {
					background: $yellow;
				}
			}

			&.half {
				grid-template-columns: 1fr 1fr;

				button:last-of-type:nth-child(odd) {
					grid-column: span 2;
				}
			}

			&.reset {
				margin-top: 1rem;

				button {
					background: $red;
					color: $white;
					border-color: $red;

					&:hover {
						color: $yellow;
						border-color: $red;
						background-color: $red;
					}
				}
			}
		}
	}
</style>
