function populate_exams(params) {
  const fragment = new DocumentFragment()
  const url = '/api/exams'

  fetch(url)
    .then(response => response.json())
    .then(data => {
      if (data.success) {
        data.data.forEach(exam => {
          const tr = document.createElement('tr')
          const token = document.createElement('td')
          token.textContent = exam.token
          const date = document.createElement('td')
          date.textContent = exam.date
          const patient = document.createElement('td')
          patient.textContent = exam.patient_cpf

          tr.appendChild(token)
          tr.appendChild(date)
          tr.appendChild(patient)
          fragment.appendChild(tr)
        });
      }
    })
    .then(() => {
      document.querySelector('tbody').appendChild(fragment)
    }).catch(error => {
      console.log(error)
    })
}
