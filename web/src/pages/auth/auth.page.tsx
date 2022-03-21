import { VFC, FormEvent, useState } from 'react'
import { useSignInWithEmailAndPassword } from 'react-firebase-hooks/auth'
import { auth } from 'shared/libs/firebase'

export const AuthPage: VFC = () => {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  const [signInWithEmailAndPassword, , isSubmitting, error] = useSignInWithEmailAndPassword(auth)

  const onFormSubmit = async (e: FormEvent) => {
    e.preventDefault()

    if (!email || !password) {
      return
    }

    signInWithEmailAndPassword(email, password)
  }

  return (
    <div>
      Auth Page
      <form onSubmit={onFormSubmit}>
        <p>
          <input
            placeholder='email'
            type='email'
            value={email}
            onChange={e => setEmail(e.target.value)}
            disabled={isSubmitting}
          />
        </p>

        <p>
          <input
            placeholder='password'
            type='password'
            value={password}
            onChange={e => setPassword(e.target.value)}
            disabled={isSubmitting}
          />
        </p>

        {!!error && <p style={{ color: 'red' }}>{error.message}</p>}

        <p>
          <button type='submit' disabled={isSubmitting}>
            {isSubmitting ? '...' : 'Submit'}
          </button>
        </p>
      </form>
    </div>
  )
}
