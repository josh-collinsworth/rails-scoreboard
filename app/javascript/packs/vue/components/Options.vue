<template v-if="game">
	<form id="options" :class="optionsMenuOpen && 'open'" :tabindex="optionsMenuOpen ? 0 : -1" :aria-hidden="!optionsMenuOpen">
		<div class="form-group">
			<label for="increment">Scores increment by:</label>
			<input type="number" id="increment" :value="game.options.increment" @change="updateIncrement">
		</div>

		<button @click="deleteThisGame">Delete this game</button>

	</form>
</template>

<script>
import axios from 'axios'

export default {
	props: {
		optionsMenuOpen: {
			type: Boolean,
			required: true
		},
		game: {
			type: Object,
			required: true
		},
		refresh: {
			type: Function,
			required: true
		}
	},
	methods: {
		updateIncrement (e) {
			let updatedGame = this.game
			updatedGame.options.increment = e.target.value
			const data = {
				game: updatedGame
			}
			axios.put(`/api/games/${this.game.id}`, data)
		},
		deleteThisGame (e) {
			e.preventDefault();
			const confirmation = confirm(`Are you sure you want to delete the game ${this.game.name}?`)
			if(confirmation) {
				axios.delete(`/api/games/${this.game.id}`)
					.then(response => {
						if (response.data.success) {
							window.location.href = `/?deleted=true&name=${this.game.name}`
						}
					})
			}
		}
	}
}
</script>

<style lang="scss" scoped>
	@import '../../../../assets/stylesheets/vars';

	#options {
		position: absolute;
		width: 100%;
		max-width: 24rem;
		padding: 1rem;
		min-height: calc(100vh - 100px);
		background: $lightBlue;
		right: 0;
		top: 4rem;
		transform: translateX(100%);
		transition: transform .2s $easing;

		&.open {
			transform: translateX(0);
		}
	}
</style>
