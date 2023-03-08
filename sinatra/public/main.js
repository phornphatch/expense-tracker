document.addEventListener('DOMContentLoaded', () => {
  const incomeOpenBtn = document.querySelector('[data-target="modal-add-income"]')
  const incomeModal = document.querySelector('#modal-add-income')
  const incomeCloseBtn = document.querySelector('[data-target="modal-add-income-close"]')
  const incomeCancelBtn = document.querySelector('[data-target="modal-add-income-cancel"]')
  
  incomeOpenBtn.addEventListener('click', () => {
    incomeModal.setAttribute('open', true)
  })

  incomeCloseBtn.addEventListener('click', () => {
    incomeModal.setAttribute('open', false)
  })

  incomeCancelBtn.addEventListener('click', () => {
    incomeModal.setAttribute('open', false)
  })
})
