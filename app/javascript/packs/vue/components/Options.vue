<template>
	<aside id="options" :class="optionsMenuOpen && 'open'" :tabindex="optionsMenuOpen ? 0 : -1" :aria-hidden="!optionsMenuOpen">
		<div class="form-group">
			<label for="increment">Scores <strong>increment</strong> by:</label>
			<input type="number" id="increment" :value="game.options.increment" @change="updateIncrement" step="1">
		</div>
		<div class="form-group tight">
			<input type="checkbox" :disabled="game.options.increment == 1" :checked="game.options.include_increment_by_one" @change="updateIncludeByOneBtns" id="also-include-one">
			<label for="also-include-one">Also include <strong>+1/-1</strong> buttons</label>
		</div>
		<div class="form-group tight">
			<input type="checkbox" :checked="game.options.add_double" @change="updateDouble" id="double">
			<label for="double">Include button to <strong>double</strong> player score</label>
		</div>
		<div class="form-group tight">
			<input type="checkbox" :checked="game.options.add_halve" @change="updateHalve" id="halve">
			<label for="halve">Include button to <strong>halve</strong> player score</label>
		</div>
		<div class="form-group tight">
			<input type="checkbox" :checked="game.options.add_reset" @change="updateReset" id="reset">
			<label for="reset">Include button to <strong>reset</strong> player to zero</label>
		</div>
		<div class="form-group">
			<label for="prepend"><strong>Prepend</strong> scores with:</label>
			<input type="text" id="prepend" :value="game.options.prepend" @change="updatePrepend" maxlength="3" placeholder="e.g., '$'">
		</div>
		<div class="form-group">
			<label for="append"><strong>Append</strong> scores with:</label>
			<input type="text" id="append" :value="game.options.append" @change="updateAppend" maxlength="3" placeholder="e.g., '.00'">
		</div>

		<button @click="deleteThisGame">Delete this game</button>

	</aside>
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
		alert: {
			type: Function,
			required: true
		}
	},
	methods: {
		updateIncrement(e) {
			let updatedGame = { game: { ...this.game } }
			updatedGame.game.options.increment = e.target.value
			this.sendUpdate(updatedGame);
		},
		updateIncludeByOneBtns(e) {
			let updatedGame = { game: { ...this.game } }
			updatedGame.game.options.include_increment_by_one = e.target.checked
			this.sendUpdate(updatedGame);
		},
		updateDouble(e) {
			let updatedGame = { game: { ...this.game } }
			updatedGame.game.options.add_double = e.target.checked
			this.sendUpdate(updatedGame);
		},
		updateHalve(e) {
			let updatedGame = { game: { ...this.game } }
			updatedGame.game.options.add_halve = e.target.checked
			this.sendUpdate(updatedGame);
		},
		updateReset(e) {
			let updatedGame = { game: { ...this.game } }
			updatedGame.game.options.add_reset = e.target.checked
			this.sendUpdate(updatedGame);
		},
		updatePrepend(e) {
			const prependWith = e.target.value
			let updatedGame = { game: { ...this.game } }
			updatedGame.game.options.prepend = prependWith
			this.sendUpdate(updatedGame);
		},
		updateAppend(e) {
			const appendWith = e.target.value
			let updatedGame = { game: { ...this.game } }
			updatedGame.game.options.append = appendWith
			this.sendUpdate(updatedGame);
		},
		sendUpdate(data) {
			axios.put(`/api/games/${this.game.id}`, data)
		},
		deleteThisGame(e) {
			e.preventDefault();
			const confirmation = confirm(`Are you sure you want to delete the game ${this.game.name}?`)
			if(confirmation) {
				axios.delete(`/api/games/${this.game.id}`)
					.then(response => {
						if (response.data.success) {
							window.location.href = `/?deleted=true&name=${this.game.name}`
						} else {
							this.alert('Error: could not create new player')
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

		&.open {
			transform: translateX(0);
		}

		.form-group {
			margin: 1rem 0;

			label,
			input {
				flex: 1 1 auto;
			}
		}

		input[type=text],
		input[type=number] {
			max-width: 6em;
		}
	}
</style>
